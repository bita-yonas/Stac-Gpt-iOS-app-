import SwiftUI

struct HomeView: View {
    @State private var navigateToChat = false
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack {
                    // Background gradient
                    LinearGradient(
                        gradient: Gradient(colors: [Color(red: 0.15, green: 0.15, blue: 0.4), Color(red: 0.1, green: 0.1, blue: 0.3)]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .ignoresSafeArea()
                    
                    ScrollView {
                        VStack(alignment: .leading, spacing: 20) {
                            // Header
                            HStack {
                                HStack {
                                    Image(systemName: "message.fill")
                                        .foregroundColor(.white)
                                        .font(.title2)
                                    Text("StacGPT")
                                        .font(.title2)
                                        .bold()
                                        .foregroundColor(.white)
                                }
                                
                                Spacer()
                                
                                HStack(spacing: 20) {
                                    Text("Home")
                                        .foregroundColor(.white)
                                        .fontWeight(.semibold)
                                    
                                    NavigationLink(destination: ContentView().navigationBarBackButtonHidden(true)) {
                                        Text("Chat")
                                            .foregroundColor(.white.opacity(0.8))
                                    }
                                }
                            }
                            .padding(.top, 15)
                            
                            NavigationLink(destination: ContentView().navigationBarBackButtonHidden(true), isActive: $navigateToChat) {
                                EmptyView()
                            }
                            
                            Spacer(minLength: 30)
                            
                            // Main content
                            VStack(alignment: .leading, spacing: 25) {
                                // AI Assistant Label
                                Text("AI-POWERED ASSISTANT")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white.opacity(0.7))
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 8)
                                    .background(Color.white.opacity(0.1))
                                    .cornerRadius(20)
                                
                                // Main heading
                                VStack(alignment: .leading, spacing: 5) {
                                    Text("Welcome to")
                                        .font(.system(size: min(36, geometry.size.width * 0.09)))
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                    
                                    Text("StacGPT")
                                        .font(.system(size: min(36, geometry.size.width * 0.09)))
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                }
                                
                                // Subheading
                                Text("Your intelligent AI assistant for St. Thomas Aquinas College community")
                                    .font(.title3)
                                    .foregroundColor(.white.opacity(0.8))
                                    .fixedSize(horizontal: false, vertical: true)
                                
                                // Spartan logo (centered for mobile)
                                ZStack {
                                    // Glowing effect
                                    Circle()
                                        .fill(Color.purple.opacity(0.3))
                                        .frame(width: 150, height: 150)
                                        .blur(radius: 30)
                                    
                                    // Spartan helmet icon
                                    Image(systemName: "shield.lefthalf.filled")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .foregroundColor(.black)
                                        .frame(width: 100, height: 100)
                                }
                                .frame(maxWidth: .infinity)
                                
                                // STAC SPARTANS AI text box
                                VStack {
                                    Text("STAC SPARTANS AI")
                                        .font(.title3)
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                    
                                    Text("• • •")
                                        .foregroundColor(.white)
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 10)
                                .background(Color.white.opacity(0.1))
                                .cornerRadius(12)
                                
                                // Buttons
                                VStack(spacing: 15) {
                                    Button(action: {
                                        print("Start Chatting button tapped")
                                        self.navigateToChat = true
                                    }) {
                                        Text("Start Chatting Now")
                                            .fontWeight(.semibold)
                                            .foregroundColor(.black)
                                            .padding(.vertical, 15)
                                            .frame(maxWidth: .infinity)
                                            .background(Color.white)
                                            .cornerRadius(8)
                                    }
                                    
                                    Button(action: {
                                        print("STAC Website button tapped")
                                    }) {
                                        Text("STAC Website")
                                            .fontWeight(.semibold)
                                            .foregroundColor(.white)
                                            .padding(.vertical, 15)
                                            .frame(maxWidth: .infinity)
                                            .background(Color.white.opacity(0.1))
                                            .cornerRadius(8)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 8)
                                                    .stroke(Color.white.opacity(0.3), lineWidth: 1)
                                            )
                                    }
                                }
                            }
                            
                            Spacer(minLength: 20)
                        }
                        .padding()
                        .frame(minHeight: geometry.size.height)
                    }
                }
                .onAppear {
                    print("HomeView appeared - width: \(geometry.size.width), height: \(geometry.size.height)")
                }
            }
            .navigationBarHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
} 
