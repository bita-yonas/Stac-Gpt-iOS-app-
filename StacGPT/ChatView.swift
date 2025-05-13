import SwiftUI

// MARK: - Chat View
struct ChatView: View {
    @ObservedObject var viewModel: ChatViewModel
    @Binding var showChat: Bool
    @Binding var animateLogo: Bool
    @Binding var showTypingIndicator: Bool
    @Binding var buttonScale: Double
    var stacColors: (gold: Color, brown: Color, maroon: Color, blue: Color)
    var sendMessageWithAnimation: () -> Void
    @State private var keyboardHeight: CGFloat = 0
    @State private var scrollToBottom = false
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            chatHeaderView
            
            // Message list
            chatMessagesView
            
            // Input field
            chatInputView
        }
        .background(stacColors.maroon)
        .edgesIgnoringSafeArea(.bottom)
        .transition(.move(edge: .trailing))
        .padding(.bottom, keyboardHeight > 0 ? keyboardHeight - 20 : 0)
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .onAppear {
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notification in
                guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
                keyboardHeight = keyboardFrame.height
                scrollToBottom = true
            }
            
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
                keyboardHeight = 0
            }
        }
    }
    
    // Header with title and back button
    private var chatHeaderView: some View {
        HStack {
            Button(action: {
                withAnimation {
                    showChat = false
                }
            }) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(10)
                    .background(stacColors.brown.opacity(0.3))
                    .clipShape(Circle())
            }
            
            Spacer()
            
            HStack(spacing: 8) {
                Image("spartan_logo")
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(stacColors.gold)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24)
                
                Text("StacGPT Chat")
                    .font(.title3)
                    .bold()
                    .foregroundColor(.white)
            }
            
            Spacer()
            
            Button(action: {}) {
                Image(systemName: "gearshape.fill")
                    .font(.system(size: 16))
                    .foregroundColor(.white)
                    .padding(10)
                    .background(stacColors.brown.opacity(0.3))
                    .clipShape(Circle())
            }
        }
        .padding()
        .background(stacColors.maroon.opacity(0.7))
    }
    
    // Messages list
    private var chatMessagesView: some View {
        ScrollViewReader { scrollView in
            ScrollView(.vertical, showsIndicators: true) {
                LazyVStack(spacing: 12) {
                    // Welcome message if no messages
                    if viewModel.messages.isEmpty {
                        welcomeMessageView
                            .padding(.top, 30)
                    }
                    
                    // Message bubbles
                    ForEach(viewModel.messages) { message in
                        MessageBubble(
                            message: message,
                            stacGold: stacColors.gold,
                            stacBlue: stacColors.blue,
                            stacBrown: stacColors.brown,
                            stacMaroon: stacColors.maroon
                        )
                        .id(message.id) // For ScrollViewReader
                    }
                    
                    // Typing indicator when loading
                    if viewModel.isLoading {
                        TypingIndicatorView(stacColors: stacColors)
                            .id("typingIndicator") // For ScrollViewReader
                    }
                    
                    // Space at bottom for better scrolling
                    Spacer()
                        .frame(height: 60)
                        .id("bottomSpacer") // For ScrollViewReader
                }
                .padding()
            }
            .background(stacColors.maroon.opacity(0.3))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .onChange(of: viewModel.messages.count) { _ in
                // Scroll to bottom when new messages appear
                withAnimation {
                    scrollView.scrollTo("bottomSpacer", anchor: .bottom)
                }
            }
            .onChange(of: scrollToBottom) { newValue in
                if newValue {
                    withAnimation {
                        scrollView.scrollTo("bottomSpacer", anchor: .bottom)
                    }
                    scrollToBottom = false
                }
            }
            .onChange(of: viewModel.isLoading) { isLoading in
                if isLoading {
                    withAnimation {
                        scrollView.scrollTo("typingIndicator", anchor: .bottom)
                    }
                }
            }
        }
    }
    
    // Welcome message
    private var welcomeMessageView: some View {
        VStack(spacing: 20) {
            Image("spartan_logo")
                .resizable()
                .renderingMode(.template)
                .foregroundColor(stacColors.gold)
                .aspectRatio(contentMode: .fit)
                .frame(width: 80, height: 80)
            
            Text("Welcome to StacGPT")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            Text("Ask me anything about St. Thomas Aquinas College!")
                .font(.body)
                .foregroundColor(.white.opacity(0.8))
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            VStack(alignment: .leading, spacing: 12) {
                suggestionButton("Tell me about STAC's history")
                suggestionButton("What majors are offered?")
                suggestionButton("How can I contact student services?")
            }
        }
        .padding()
        .background(stacColors.maroon.opacity(0.3))
        .cornerRadius(15)
    }
    
    // Suggestion button
    private func suggestionButton(_ text: String) -> some View {
        Button(action: {
            viewModel.inputMessage = text
            sendMessageWithAnimation()
        }) {
            HStack {
                Text(text)
                    .font(.subheadline)
                    .foregroundColor(.white)
                Spacer()
                Image(systemName: "arrow.right")
                    .font(.system(size: 12))
                    .foregroundColor(stacColors.gold)
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 15)
            .background(stacColors.brown.opacity(0.3))
            .cornerRadius(10)
        }
    }
    
    // Input field and send button
    private var chatInputView: some View {
        VStack(spacing: 16) {
            // Suggested prompts like in ChatGPT
            if viewModel.messages.isEmpty || viewModel.messages.count < 2 {
                HStack(spacing: 12) {
                    // First prompt suggestion
                    Button(action: {
                        viewModel.inputMessage = "Tell me about STAC's history"
                        sendMessageWithAnimation()
                    }) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Tell me about STAC's history")
                                .font(.subheadline)
                                .fontWeight(.medium)
                                .foregroundColor(.white)
                                .multilineTextAlignment(.leading)
                                .lineLimit(1)
                        }
                        .padding(.vertical, 12)
                        .padding(.horizontal, 16)
                        .background(Color.black.opacity(0.3))
                        .cornerRadius(16)
                    }
                    
                    // Second prompt suggestion
                    Button(action: {
                        viewModel.inputMessage = "What majors are offered?"
                        sendMessageWithAnimation()
                    }) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("What majors are offered?")
                                .font(.subheadline)
                                .fontWeight(.medium)
                                .foregroundColor(.white)
                                .multilineTextAlignment(.leading)
                                .lineLimit(1)
                        }
                        .padding(.vertical, 12)
                        .padding(.horizontal, 16)
                        .background(Color.black.opacity(0.3))
                        .cornerRadius(16)
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 8)
            }
            
            // Input row
            HStack(spacing: 8) {
                // Additional actions button
                Button(action: {
                    // Add additional actions here
                }) {
                    Image(systemName: "plus")
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                        .frame(width: 32, height: 32)
                }
                
                // Text field with dark background
                ZStack(alignment: .leading) {
                    // Background for the text field
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.black.opacity(0.4))
                    
                    // Placeholder text
                    if viewModel.inputMessage.isEmpty {
                        Text("Message StacGPT")
                            .foregroundColor(.gray)
                            .padding(.leading, 16)
                    }
                    
                    // Actual text field
                    TextField("", text: $viewModel.inputMessage)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
                        .foregroundColor(.white)
                        .accentColor(stacColors.gold)
                }
                .frame(height: 44)
                
                // Send button
                Button(action: {
                    sendMessageWithAnimation()
                }) {
                    Image(systemName: "arrow.up")
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                        .frame(width: 32, height: 32)
                        .background(
                            Circle()
                                .fill(stacColors.gold)
                        )
                }
                .disabled(viewModel.isLoading || viewModel.inputMessage.isEmpty)
                .scaleEffect(buttonScale)
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
            .background(Color.black.opacity(0.3))
        }
    }
}

// MARK: - Typing Indicator View
struct TypingIndicatorView: View {
    var stacColors: (gold: Color, brown: Color, maroon: Color, blue: Color)
    @State private var isAnimating = false
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 15) {
            // Bot avatar
            ZStack {
                Circle()
                    .fill(stacColors.gold.opacity(0.2))
                    .frame(width: 36, height: 36)
                    
                Image("spartan_logo")
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(stacColors.gold)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24)
            }
            
            // Dots animation
            HStack(spacing: 4) {
                ForEach(0..<3) { index in
                    Circle()
                        .fill(stacColors.gold)
                        .frame(width: 8, height: 8)
                        .scaleEffect(isAnimating ? 1.2 : 0.8)
                        .animation(
                            Animation.easeInOut(duration: 0.6)
                                .repeatForever()
                                .delay(Double(index) * 0.2),
                            value: isAnimating
                        )
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color.white.opacity(0.15))
            .cornerRadius(18)
            
            Spacer()
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .transition(.opacity)
        .onAppear {
            isAnimating = true
        }
    }
}

// MARK: - Preview
#if DEBUG
struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ChatViewModel()
        
        // Add a couple of sample messages
        viewModel.messages = [
            ChatMessage(content: "Hi there! I'm StacGPT, your educational assistant for St. Thomas Aquinas College. How can I help you today?", isFromUser: false),
            ChatMessage(content: "Tell me about the academic programs", isFromUser: true),
            ChatMessage(content: "St. Thomas Aquinas College offers a wide range of academic programs across three schools: the School of Arts & Sciences, the School of Business, and the School of Education. Programs include Business Administration, Criminal Justice, Education, Psychology, and many more.", isFromUser: false)
        ]
        
        return ChatView(
            viewModel: viewModel,
            showChat: .constant(true),
            animateLogo: .constant(true),
            showTypingIndicator: .constant(false),
            buttonScale: .constant(1.0),
            stacColors: (
                gold: Color(red: 0.933, green: 0.733, blue: 0.227),
                brown: Color(red: 0.41, green: 0.275, blue: 0.2),
                maroon: Color(red: 0.535, green: 0.125, blue: 0.204),
                blue: Color(red: 0.082, green: 0.106, blue: 0.173)
            ),
            sendMessageWithAnimation: {}
        )
    }
}
#endif 
