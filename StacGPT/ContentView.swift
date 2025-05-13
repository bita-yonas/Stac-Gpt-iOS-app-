import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ChatViewModel()
    @Environment(\.presentationMode) var presentationMode
    @State private var showChat = false
    @State private var animateGradient = false
    @State private var animateLogo = false
    @State private var showTypingIndicator = false
    @State private var typingText = ""
    @State private var buttonScale = 1.0
    @State private var showCalendar = false
    @State private var showCampusNavigation = false
    @State private var showAcademicSupport = false
    
    // STAC College Colors
    private let stacGold = Color(red: 0.933, green: 0.733, blue: 0.227) // #EE BB 3A - exact gold from website
    private let stacMaroon = Color(red: 0.535, green: 0.125, blue: 0.204) // #882033 - exact maroon from website
    private let stacBrown = Color(red: 0.41, green: 0.275, blue: 0.2) // #694633
    private let stacBlue = Color(red: 0.082, green: 0.106, blue: 0.173) // #151B2C
    private let stacBlue2 = Color(red: 0.149, green: 0.22, blue: 0.318) // #263851
    
    private let typingTexts = [
        "Answering campus questions...",
        "Finding resources...",
        "Providing academic support...",
        "Helping students succeed..."
    ]
    
    var body: some View {
        ZStack(alignment: .top) {
            // Content
            if showChat {
                ChatView(
                    viewModel: viewModel,
                    showChat: $showChat,
                    animateLogo: $animateLogo,
                    showTypingIndicator: $showTypingIndicator,
                    buttonScale: $buttonScale,
                    stacColors: (stacGold, stacBrown, stacMaroon, stacBlue),
                    sendMessageWithAnimation: sendMessageWithAnimation
                )
            } else {
                // Landing page content
                landingPageContent
            }
        }
        .onAppear {
            // Start animations when the view appears
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation(.easeInOut(duration: 1.5)) {
                    animateLogo = true
                }
            }
        }
    }
    
    // Landing page
    private var landingPageContent: some View {
        ZStack(alignment: .top) {
            // Background gradient
            LinearGradient(
                gradient: Gradient(colors: [
                    stacMaroon,
                    stacMaroon.opacity(0.9),
                    stacMaroon.opacity(0.8)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            // Simple scroll view with content
            ScrollView(showsIndicators: true) {
                VStack(spacing: 30) {
                    // Extra space for header
                    Spacer(minLength: 70)
                    
                    // AI Label
                    Text("AI-POWERED ASSISTANT")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(stacGold)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(stacMaroon.opacity(0.4))
                        .cornerRadius(20)
                    
                    // Welcome heading
                    Text("Welcome to")
                        .font(.system(size: 36))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                    
                    Text("StacGPT")
                        .font(.system(size: 36))
                        .fontWeight(.bold)
                        .foregroundColor(stacGold)
                        .multilineTextAlignment(.center)
                    
                    // Subheading
                    Text("Your intelligent AI assistant for St. Thomas Aquinas College community")
                        .font(.title3)
                        .foregroundColor(.white.opacity(0.8))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    // Spartan logo
                    spartanLogo
                    
                    // Animated typing
                    typingIndicator
                    
                    // Start chat button
                    Button(action: {
                        withAnimation(.spring(response: 0.6, dampingFraction: 0.7)) {
                            showChat = true
                        }
                    }) {
                        HStack {
                            Text("Start Chatting Now")
                                .fontWeight(.semibold)
                            
                            Image(systemName: "arrow.right")
                                .font(.system(size: 16, weight: .semibold))
                        }
                        .foregroundColor(stacMaroon)
                        .padding(.vertical, 15)
                        .frame(maxWidth: .infinity)
                        .background(stacGold)
                        .cornerRadius(12)
                    }
                    .padding(.horizontal)
                    
                    // Features section
                    featuresSection
                    
                    // Services section
                    servicesSection
                    
                    // About section
                    aboutSection
                    
                    // Campus Resources section
                    campusResourcesSection
                    
                    // Student Life section
                    studentLifeSection
                    
                    // Alumni section
                    alumniSection
                    
                    // FAQ section
                    faqSection
                    
                    // Footer with credits
                    footerSection
                }
                .padding()
                .frame(maxWidth: .infinity)
            }
            
            // Header stays fixed at top
            stickyHeader
                .zIndex(2)
        }
    }
    
    // Header view
    private var stickyHeader: some View {
        HStack {
            HStack {
                Image(systemName: "message.fill")
                    .foregroundColor(stacGold)
                    .font(.title2)
                Text("StacGPT")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.white)
            }
            
            Spacer()
            
            Button(action: {
                withAnimation {
                    showChat = true
                }
            }) {
                Text("Chat")
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(stacGold)
                    .cornerRadius(20)
            }
        }
        .padding()
        .background(stacMaroon.opacity(0.7))
    }
    
    // Spartan logo
    private var spartanLogo: some View {
        ZStack {
            // Simple glow effect
            Circle()
                .fill(stacGold.opacity(0.15))
                .frame(width: 140, height: 140)
                .blur(radius: 15)
                .scaleEffect(animateLogo ? 1 : 0)
                .animation(.easeOut(duration: 1.0), value: animateLogo)

            // Main logo with reveal effect
            Image("spartan_logo")
                .resizable()
                .renderingMode(.template)
                .foregroundColor(stacGold)
                .aspectRatio(contentMode: .fit)
                .frame(width: 120, height: 120)
                .scaleEffect(animateLogo ? 1 : 0.7)
                .opacity(animateLogo ? 1 : 0)
                .animation(.spring(response: 0.6, dampingFraction: 0.7), value: animateLogo)
                .shadow(color: stacGold.opacity(0.5), radius: 10)
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }
    
    // Particle animation positions
    private let particleOffsets: [(CGFloat, CGFloat)] = [
        (50, -50), (-50, -50), (50, 50), (-50, 50),
        (70, 0), (-70, 0), (0, 70), (0, -70)
    ]
    
    // Typing indicator
    private var typingIndicator: some View {
        VStack {
            Text(typingText)
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .onAppear {
                    startTypingAnimation()
                }
            
            Text("• • •")
                .foregroundColor(stacGold)
        }
        .frame(height: 80)
        .frame(maxWidth: .infinity)
        .background(stacMaroon.opacity(0.3))
        .cornerRadius(12)
        .padding(.horizontal)
    }
    
    // MARK: - Features Section
    private var featuresSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("FEATURES")
                .font(.headline)
                .foregroundColor(stacGold)
                .padding(.horizontal, 20)
            
            ScrollView(.horizontal, showsIndicators: true) {
                HStack(spacing: 15) {
                    // Academic Support feature card with button action
                    Button(action: {
                        showAcademicSupport = true
                    }) {
                        VStack(spacing: 10) {
                            Image(systemName: "graduationcap.fill")
                                .font(.system(size: 30))
                                .foregroundColor(stacGold)
                            
                            Text("Academic Support")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                        }
                        .frame(width: 120, height: 100)
                        .background(stacMaroon.opacity(0.3))
                        .cornerRadius(12)
                    }
                    .sheet(isPresented: $showAcademicSupport) {
                        AcademicSupportView(isPresented: $showAcademicSupport, stacGold: stacGold, stacMaroon: stacMaroon)
                    }
                    
                    // Campus Navigation feature card with button action
                    Button(action: {
                        showCampusNavigation = true
                    }) {
                        VStack(spacing: 10) {
                            Image(systemName: "map.fill")
                                .font(.system(size: 30))
                                .foregroundColor(stacGold)
                            
                            Text("Campus Navigation")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                        }
                        .frame(width: 120, height: 100)
                        .background(stacMaroon.opacity(0.3))
                        .cornerRadius(12)
                    }
                    .sheet(isPresented: $showCampusNavigation) {
                        CampusNavigationView(isPresented: $showCampusNavigation, stacGold: stacGold, stacMaroon: stacMaroon)
                    }
                    
                    // Calendar feature with its own sheet
                    Button(action: {
                        showCalendar = true
                    }) {
                        VStack(spacing: 10) {
                            Image(systemName: "calendar")
                                .font(.system(size: 30))
                                .foregroundColor(stacGold)
                            
                            Text("Events & Activities")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                        }
                        .frame(width: 120, height: 100)
                        .background(stacMaroon.opacity(0.3))
                        .cornerRadius(12)
                    }
                    .sheet(isPresented: $showCalendar) {
                        CalendarView(isPresented: $showCalendar, stacGold: stacGold, stacMaroon: stacMaroon)
                    }
                    
                    featureCard(icon: "person.3.fill", title: "Student Resources")
                }
                .padding(.horizontal, 20)
            }
            .frame(height: 130)
        }
    }
    
    private func featureCard(icon: String, title: String) -> some View {
        Button(action: {
            // Handle other feature cards that don't have sheets
        }) {
            VStack(spacing: 10) {
                Image(systemName: icon)
                    .font(.system(size: 30))
                    .foregroundColor(stacGold)
                
                Text(title)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
            }
            .frame(width: 120, height: 100)
            .background(stacMaroon.opacity(0.3))
            .cornerRadius(12)
        }
    }
    
    // MARK: - Services Section
    private var servicesSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("SERVICES")
                .font(.headline)
                .foregroundColor(stacGold)
                .padding(.horizontal, 20)
            
            ScrollView(.horizontal, showsIndicators: true) {
                HStack(spacing: 20) {
                    serviceCard(icon: "book.fill", title: "Academic Resources")
                    serviceCard(icon: "person.fill.questionmark", title: "FAQ & Help Center")
                    serviceCard(icon: "bell.fill", title: "Announcements")
                    serviceCard(icon: "calendar.badge.clock", title: "Schedules")
                }
                .padding(.horizontal, 20)
            }
            .frame(height: 200)
        }
    }
    
    private func serviceCard(icon: String, title: String) -> some View {
        VStack(spacing: 15) {
            Image(systemName: icon)
                .font(.system(size: 30))
                .foregroundColor(stacGold)
            
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .frame(width: 120)
        }
        .frame(width: 150, height: 150)
        .background(stacMaroon.opacity(0.3))
        .cornerRadius(12)
    }
    
    // MARK: - About Section
    private var aboutSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("ABOUT STAC")
                .font(.headline)
                .foregroundColor(stacGold)
                .padding(.horizontal, 20)
            
            Text("St. Thomas Aquinas College is a vibrant, independent liberal arts college founded by the Dominican Sisters of Sparkill. STAC offers over 100 programs in the School of Arts & Sciences, the School of Business, and the School of Education.")
                .font(.body)
                .foregroundColor(.white.opacity(0.8))
                .lineSpacing(4)
                .padding(.horizontal, 20)
        }
    }
    
    // MARK: - Campus Resources Section
    private var campusResourcesSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("CAMPUS RESOURCES")
                .font(.headline)
                .foregroundColor(stacGold)
                .padding(.horizontal, 20)
            
            resourceCard(title: "Library", icon: "books.vertical.fill")
            resourceCard(title: "Fitness Center", icon: "figure.run")
            resourceCard(title: "Student Center", icon: "building.2.fill")
        }
    }
    
    private func resourceCard(title: String, icon: String) -> some View {
        HStack {
            Image(systemName: icon)
                .font(.system(size: 25))
                .foregroundColor(stacGold)
                .frame(width: 40)
            
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(stacGold)
        }
        .padding()
        .background(stacMaroon.opacity(0.3))
        .cornerRadius(12)
        .padding(.horizontal, 20)
    }
    
    // MARK: - Student Life Section
    private var studentLifeSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("STUDENT LIFE")
                .font(.headline)
                .foregroundColor(stacGold)
                .padding(.horizontal, 20)
            
            Text("St. Thomas Aquinas College offers a rich campus life with over 40 clubs and organizations, NCAA Division II athletics, and various events throughout the academic year.")
                .font(.body)
                .foregroundColor(.white.opacity(0.8))
                .lineSpacing(4)
                .padding(.horizontal, 20)
        }
    }
    
    // MARK: - Alumni Section
    private var alumniSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("ALUMNI SPOTLIGHT")
                .font(.headline)
                .foregroundColor(stacGold)
                .padding(.horizontal, 20)
            
            alumniCard(name: "Sarah Johnson", year: "Class of 2018")
            alumniCard(name: "Michael Rodriguez", year: "Class of 2015")
        }
    }
    
    private func alumniCard(name: String, year: String) -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(name)
                    .font(.headline)
                    .foregroundColor(.white)
                
                Text(year)
                    .font(.subheadline)
                    .foregroundColor(stacGold)
            }
            
            Spacer()
            
            Image(systemName: "person.crop.circle.fill")
                .font(.system(size: 30))
                .foregroundColor(stacGold)
        }
        .padding()
        .background(stacMaroon.opacity(0.3))
        .cornerRadius(12)
        .padding(.horizontal, 20)
    }
    
    // MARK: - FAQ Section
    private var faqSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("FREQUENTLY ASKED QUESTIONS")
                .font(.headline)
                .foregroundColor(stacGold)
                .padding(.horizontal, 20)
            
            faqItem(question: "How can StacGPT help me?")
            faqItem(question: "Is StacGPT available 24/7?")
            faqItem(question: "What information can I find on StacGPT?")
        }
    }
    
    private func faqItem(question: String) -> some View {
        HStack {
            Text(question)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(.white)
            
            Spacer()
            
            Image(systemName: "chevron.down")
                .font(.system(size: 14))
                .foregroundColor(stacGold)
        }
        .padding()
        .background(stacMaroon.opacity(0.3))
        .cornerRadius(12)
        .padding(.horizontal, 20)
    }
    
    // MARK: - Footer Section
    private var footerSection: some View {
        VStack(spacing: 20) {
            Text("© 2023 St. Thomas Aquinas College")
                .font(.caption)
                .foregroundColor(.white.opacity(0.7))
            
            Text("Powered by StacGPT")
                .font(.caption)
                .foregroundColor(stacGold.opacity(0.7))
                
            Spacer().frame(height: 20)
        }
        .padding()
        .frame(maxWidth: .infinity)
    }
    
    // Helper functions
    private func sendMessageWithAnimation() {
        guard !viewModel.inputMessage.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
        
        // Add haptic feedback
        let impactMed = UIImpactFeedbackGenerator(style: .medium)
        impactMed.impactOccurred()
        
        // Animate button
        buttonScale = 0.8
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            buttonScale = 1.0
        }
        
        // Send message
        viewModel.sendMessage()
    }
    
    private func startTypingAnimation() {
        var index = 0
        
        func animateText() {
            withAnimation {
                typingText = typingTexts[index % typingTexts.count]
            }
            index += 1
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                animateText()
            }
        }
        
        // Start the animation loop
        animateText()
    }
}

// MARK: - Blur View for iOS 15+
struct BlurView: UIViewRepresentable {
    var style: UIBlurEffect.Style
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}

// MARK: - Scroll Offset Preference Key
struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

// MARK: - Supporting Views and Modifiers

// Backdrop blur for glassmorphism effect
struct BackdropBlurView: UIViewRepresentable {
    var radius: CGFloat = 3
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialDark))
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: .systemUltraThinMaterialDark)
    }
}

// Shine effect for badges
struct ShineEffect: View {
    @State private var shine = false
    
    var body: some View {
        GeometryReader { geometry in
            Color.clear
                .overlay(
                    Rectangle()
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [.clear, .white.opacity(0.5), .clear]),
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .rotationEffect(.degrees(70))
                        .offset(x: shine ? geometry.size.width : -geometry.size.width * 2)
                        .animation(
                            Animation.linear(duration: 2)
                                .repeatForever(autoreverses: false)
                                .delay(3),
                            value: shine
                        )
                )
                .onAppear {
                    shine = true
                }
        }
    }
}

// Custom button style with scale effect
struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.92 : 1)
            .animation(.spring(response: 0.3, dampingFraction: 0.7), value: configuration.isPressed)
    }
}

struct CalendarView: View {
    @Binding var isPresented: Bool
    var stacGold: Color
    var stacMaroon: Color
    @State private var selectedDate = Date()
    @State private var showGoogleCalendar = false
    
    var body: some View {
        NavigationView {
            VStack {
                // Calendar
                DatePicker(
                    "Select Date",
                    selection: $selectedDate,
                    displayedComponents: [.date]
                )
                .datePickerStyle(.graphical)
                .tint(stacGold)
                .padding()
                
                // View in Google Calendar Button
                Button(action: {
                    if let url = URL(string: "https://calendar.google.com/calendar/u/0/embed?src=stac.edu_calendar@group.calendar.google.com") {
                        UIApplication.shared.open(url)
                    }
                }) {
                    HStack {
                        Image(systemName: "calendar")
                        Text("View Full Calendar")
                    }
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(stacGold)
                    .cornerRadius(10)
                }
                .padding()
                
                Spacer()
            }
            .navigationTitle("Events & Activities")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isPresented = false
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(stacGold)
                    }
                }
            }
        }
    }
}

struct CampusNavigationView: View {
    @Binding var isPresented: Bool
    var stacGold: Color
    var stacMaroon: Color
    @State private var selectedBuilding: String? = nil
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background color
                stacMaroon.opacity(0.95)
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 0) {
                        // Campus Aerial Map at the top
                        ZStack {
                            // Large campus aerial image or placeholder
                            Group {
                                if UIImage(named: "campus_aerial") != nil {
                                    Image("campus_aerial")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(height: 380)
                                        .clipped()
                                } else {
                                    // Placeholder for missing campus aerial image
                                    ZStack {
                                        Rectangle()
                                            .fill(stacMaroon.opacity(0.3))
                                            .frame(height: 380)
                                        
                                        Image(systemName: "map")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 100, height: 100)
                                            .foregroundColor(stacGold)
                                        
                                        Text("Campus Map")
                                            .foregroundColor(stacGold)
                                            .font(.title2)
                                            .offset(y: 70)
                                    }
                                }
                            }
                            .overlay(
                                LinearGradient(
                                    gradient: Gradient(colors: [.clear, stacMaroon.opacity(0.5)]),
                                    startPoint: .center,
                                    endPoint: .bottom
                                )
                            )
                        }
                        .frame(height: 380)
                        
                        // Campus buildings sections
                        VStack(spacing: 20) {
                            Text("Explore Our Campus")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(stacGold)
                                .padding(.top, 20)
                                .padding(.bottom, 10)
                            
                            // Academic Buildings
                            buildingSection(title: "ACADEMICS", buildings: [
                                ("Aquinas Hall", "Campus Safety & Security, Mail Room, Athletics office, and Gymnasium"),
                                ("Costello Hall", "Sciences building with Biology and Chemistry Labs"),
                                ("Lougheed Library", "Library and Center for Academic Excellence"),
                                ("Maguire Hall", "Classrooms, art studios, and Exercise Science Lab"),
                                ("Spellman Hall", "Academic offices and classrooms")
                            ])
                            
                            // Athletics
                            buildingSection(title: "ATHLETICS", buildings: [
                                ("Spartan Athletic Complex", "Home to Soccer, Softball, and other sports"),
                                ("Kraus Fitness Center", "State-of-the-art fitness facility")
                            ])
                            
                            // Campus Life
                            buildingSection(title: "CAMPUS LIFE", buildings: [
                                ("Romano Student Center", "Student hub with dining and activities"),
                                ("McNelis Commons", "Modern dining facility"),
                                ("Fitzpatrick Village", "Student residential complex")
                            ])
                        }
                        .padding(.vertical)
                    }
                }
                .navigationTitle("")  // Removing the "Campus Tour" title
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            isPresented = false
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(stacGold)
                        }
                    }
                }
                .edgesIgnoringSafeArea(.top)
            }
        }
        .sheet(isPresented: Binding<Bool>(
            get: { selectedBuilding != nil },
            set: { if !$0 { selectedBuilding = nil } }
        )) {
            if let building = selectedBuilding {
                buildingDetailView(for: building)
            }
        }
    }
    
    private func buildingSection(title: String, buildings: [(String, String)]) -> some View {
        VStack(alignment: .leading, spacing: 15) {
            Text(title)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(stacGold)
                .padding(.horizontal)
            
            ForEach(buildings, id: \.0) { building in
                Button(action: {
                    selectedBuilding = building.0
                }) {
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(building.0)
                                .font(.headline)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                            Text(building.1)
                                .font(.subheadline)
                                .foregroundColor(.white.opacity(0.9))
                                .lineLimit(2)
                        }
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(stacGold)
                            .font(.system(size: 16, weight: .bold))
                    }
                    .padding()
                    .background(Color(red: 0.8, green: 0.7, blue: 0.75).opacity(0.4))
                    .cornerRadius(12)
                }
                .padding(.horizontal)
            }
        }
    }
    
    private func buildingDetailView(for buildingName: String) -> some View {
        NavigationView {
            ZStack {
                // Background gradient
                LinearGradient(
                    gradient: Gradient(colors: [
                        stacMaroon,
                        stacMaroon.opacity(0.9)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 20) {
                        // Use a placeholder if the image is missing
                        Group {
                            if UIImage(named: buildingName.lowercased().replacingOccurrences(of: " ", with: "_")) != nil {
                                Image(buildingName.lowercased().replacingOccurrences(of: " ", with: "_"))
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(height: 250)
                                    .clipped()
                            } else {
                                // Placeholder for missing building image
                                ZStack {
                                    Rectangle()
                                        .fill(stacMaroon.opacity(0.3))
                                        .frame(height: 250)
                                    
                                    Image(systemName: "building.2")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 100, height: 100)
                                        .foregroundColor(stacGold)
                                    
                                    Text("Building Image")
                                        .foregroundColor(stacGold)
                                        .font(.caption)
                                        .offset(y: 70)
                                }
                            }
                        }
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(stacGold, lineWidth: 2)
                        )
                        .padding(.horizontal)
                        .padding(.top)
                        
                        Text(buildingName)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(stacGold)
                            .padding(.horizontal)
                        
                        VStack(alignment: .leading, spacing: 15) {
                            // Building description would go here
                            Text(getBuildingDescription(buildingName))
                                .foregroundColor(.white)
                                .lineSpacing(5)
                                .padding()
                                .background(Color.black.opacity(0.2))
                                .cornerRadius(8)
                        }
                        .padding(.horizontal)
                        
                        Spacer()
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            selectedBuilding = nil
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(stacGold)
                        }
                    }
                }
            }
        }
    }
    
    // Return detailed descriptions for each building
    private func getBuildingDescription(_ buildingName: String) -> String {
        switch buildingName {
        case "Aquinas Hall":
            return "Located in the center of academic buildings, Aquinas Hall houses Campus Safety & Security, the Mail Room, the Athletics office, and Gymnasium and Kraus Fitness Center. This central hub is where students can find many essential services."
        case "Costello Hall":
            return "This is our sciences building where you will find the Berdais Biology and the Casazza Chemistry Labs. This building is often referred to as a \"second home\" for our science students who spend a majority of their academic time in class and in the labs. Be sure to stop by and enjoy the latest exhibit at the Azarian-McCullough Art Gallery or step outside for some fresh air and relax at the Poggi Family Terrace."
        case "Lougheed Library":
            return "The Lougheed Library is the perfect space where students find a quiet spot to study. For students looking for extra support, our Center for Academic Excellence is here to help with tutoring and more. With modern facilities and resources, the library serves as an essential academic resource for all students."
        case "Maguire Hall":
            return "Home to classrooms, art studios, and a modern, fully equipped Exercise Science Lab. Maguire Hall is also home to the popular Sullivan Theatre, where performances and events are regularly held throughout the academic year."
        case "Spellman Hall":
            return "One of our main academic buildings with many academic and administrative offices including the Provost's office, Disability Services, HEOP, Pathways, the School of Arts & Social Sciences, the School of STEM, and the Student Success Office. There's a plethora of state-of-the-art classrooms, a digital and TV studio, along with the Registrar's office and Student Financial Services."
        case "Spartan Athletic Complex":
            return "Home to our Soccer, Softball, Lacrosse, and Women's Field Hockey teams. Come and cheer on our Spartan student-athletes! The complex features well-maintained fields and facilities for multiple sports programs."
        case "Kraus Fitness Center":
            return "State-of-the-art fitness facility featuring modern equipment, cardio machines, and advanced training technology. The center offers various fitness programs and is available to all students, faculty, and staff."
        case "Romano Student Center":
            return "A favorite campus hangout, the Romano Student Center is the hub of campus life. Here, students come to relax, grab a bite to eat or enjoy freshly brewed coffee from the Spartan Grille. The lower level features dedicated spaces for gaming, sports-related watch parties, billiards, and a \"Central Perk\" coffee lounge area."
        case "McNelis Commons":
            return "Whether you have time to dine with friends or need to grab a quick bite, you will find a wide variety of options for all tastes. The dining facility offers nutritious meals prepared by skilled culinary staff."
        case "Fitzpatrick Village":
            return "A comfortable \"home\" for our students to grow and thrive! Here, upperclassmen find residential suites featuring modern two-person bedrooms with a large common area on each of its two floors. The village provides a community environment where students can study and socialize."
        default:
            return "Explore this building to learn more about the facilities and services offered. Each building at St. Thomas Aquinas College is designed to enhance the student experience and provide resources for academic success."
        }
    }
}

struct BuildingInfo: Identifiable {
    let id = UUID()
    let name: String
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .previewDisplayName("Full View")
            
            ContentView()
                .previewLayout(.sizeThatFits)
                .previewDisplayName("Sized View")
        }
    }
}

struct AcademicSupportView: View {
    @Binding var isPresented: Bool
    var stacGold: Color
    var stacMaroon: Color
    @State private var selectedService: String? = nil
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background color
                stacMaroon.opacity(0.95)
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 0) {
                        // Header image
                        ZStack {
                            // Placeholder for academic support image
                            ZStack {
                                Rectangle()
                                    .fill(stacMaroon.opacity(0.3))
                                    .frame(height: 200)
                                
                                Image(systemName: "graduationcap.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 100, height: 100)
                                    .foregroundColor(stacGold)
                                
                                Text("Academic Support")
                                    .foregroundColor(stacGold)
                                    .font(.title2)
                                    .offset(y: 70)
                            }
                            .overlay(
                                LinearGradient(
                                    gradient: Gradient(colors: [.clear, stacMaroon.opacity(0.5)]),
                                    startPoint: .center,
                                    endPoint: .bottom
                                )
                            )
                        }
                        .frame(height: 200)
                        
                        // Academic support sections
                        VStack(spacing: 20) {
                            Text("Academic Support Services")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(stacGold)
                                .padding(.top, 20)
                                .padding(.bottom, 10)
                            
                            // Center for Academic Excellence
                            supportSection(title: "CENTER FOR ACADEMIC EXCELLENCE", services: [
                                ("Tutoring Services", "One-on-one and group tutoring in various subjects"),
                                ("Writing Center", "Assistance with writing assignments at all stages"),
                                ("Math Lab", "Support for mathematics courses and problem-solving"),
                                ("Study Skills Workshops", "Time management and study strategies")
                            ])
                            
                            // Academic Advising
                            supportSection(title: "ACADEMIC ADVISING", services: [
                                ("Faculty Advisors", "Personalized guidance from faculty members"),
                                ("Major Exploration", "Help with choosing and changing majors"),
                                ("Course Planning", "Assistance with course selection and scheduling"),
                                ("Degree Progress", "Tracking academic progress and requirements")
                            ])
                            
                            // Disability Services
                            supportSection(title: "DISABILITY SERVICES", services: [
                                ("Accommodations", "Support for students with documented disabilities"),
                                ("Accessibility Resources", "Assistive technology and learning aids"),
                                ("Testing Accommodations", "Special arrangements for exams"),
                                ("Advocacy Support", "Guidance and advocacy services")
                            ])
                            
                            // Student Success
                            supportSection(title: "STUDENT SUCCESS", services: [
                                ("Academic Coaching", "Personalized success strategies"),
                                ("Time Management", "Tools and techniques for effective planning"),
                                ("Goal Setting", "Academic and personal goal development"),
                                ("Success Workshops", "Regular workshops on academic success")
                            ])
                        }
                        .padding(.vertical)
                    }
                }
                .navigationTitle("")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            isPresented = false
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(stacGold)
                        }
                    }
                }
                .edgesIgnoringSafeArea(.top)
            }
        }
        .sheet(isPresented: Binding<Bool>(
            get: { selectedService != nil },
            set: { if !$0 { selectedService = nil } }
        )) {
            if let service = selectedService {
                serviceDetailView(for: service)
            }
        }
    }
    
    private func supportSection(title: String, services: [(String, String)]) -> some View {
        VStack(alignment: .leading, spacing: 15) {
            Text(title)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(stacGold)
                .padding(.horizontal)
            
            ForEach(services, id: \.0) { service in
                Button(action: {
                    selectedService = service.0
                }) {
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(service.0)
                                .font(.headline)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                            Text(service.1)
                                .font(.subheadline)
                                .foregroundColor(.white.opacity(0.9))
                                .lineLimit(2)
                        }
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(stacGold)
                            .font(.system(size: 16, weight: .bold))
                    }
                    .padding()
                    .background(Color(red: 0.8, green: 0.7, blue: 0.75).opacity(0.4))
                    .cornerRadius(12)
                }
                .padding(.horizontal)
            }
        }
    }
    
    private func serviceDetailView(for serviceName: String) -> some View {
        NavigationView {
            ZStack {
                // Background gradient
                LinearGradient(
                    gradient: Gradient(colors: [
                        stacMaroon,
                        stacMaroon.opacity(0.9)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 20) {
                        // Service icon
                        ZStack {
                            Circle()
                                .fill(stacGold.opacity(0.2))
                                .frame(width: 120, height: 120)
                            
                            Image(systemName: getServiceIcon(serviceName))
                                .font(.system(size: 50))
                                .foregroundColor(stacGold)
                        }
                        .padding(.top)
                        
                        Text(serviceName)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(stacGold)
                            .padding(.horizontal)
                        
                        VStack(alignment: .leading, spacing: 15) {
                            Text(getServiceDescription(serviceName))
                                .foregroundColor(.white)
                                .lineSpacing(5)
                                .padding()
                                .background(Color.black.opacity(0.2))
                                .cornerRadius(8)
                            
                            // Contact information
                            if let contact = getServiceContact(serviceName) {
                                VStack(alignment: .leading, spacing: 10) {
                                    Text("Contact Information")
                                        .font(.headline)
                                        .foregroundColor(stacGold)
                                    
                                    Text(contact)
                                        .foregroundColor(.white)
                                }
                                .padding()
                                .background(Color.black.opacity(0.2))
                                .cornerRadius(8)
                            }
                        }
                        .padding(.horizontal)
                        
                        Spacer()
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            selectedService = nil
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(stacGold)
                        }
                    }
                }
            }
        }
    }
    
    private func getServiceIcon(_ serviceName: String) -> String {
        switch serviceName {
        case "Tutoring Services": return "person.2.fill"
        case "Writing Center": return "pencil.and.ellipsis.rectangle"
        case "Math Lab": return "function"
        case "Study Skills Workshops": return "book.fill"
        case "Faculty Advisors": return "person.fill"
        case "Major Exploration": return "magnifyingglass"
        case "Course Planning": return "calendar"
        case "Degree Progress": return "checkmark.circle.fill"
        case "Accommodations": return "figure.stand"
        case "Accessibility Resources": return "accessibility.fill"
        case "Testing Accommodations": return "doc.text.fill"
        case "Advocacy Support": return "hand.raised.fill"
        case "Academic Coaching": return "brain.head.profile"
        case "Time Management": return "clock.fill"
        case "Goal Setting": return "target"
        case "Success Workshops": return "person.3.fill"
        default: return "questionmark.circle.fill"
        }
    }
    
    private func getServiceDescription(_ serviceName: String) -> String {
        switch serviceName {
        case "Tutoring Services":
            return "The Tutoring Center provides one-on-one and group tutoring sessions in various subjects. Tutors are trained to help students develop effective study strategies and improve their understanding of course material. Sessions are available by appointment and on a walk-in basis."
        case "Writing Center":
            return "The Writing Center offers assistance with writing assignments at all stages of the writing process. Writing consultants help with brainstorming, outlining, drafting, and revising. Services are available for all types of writing, from essays to research papers."
        case "Math Lab":
            return "The Math Lab provides support for mathematics courses at all levels. Tutors help students with problem-solving strategies, homework assignments, and exam preparation. The lab is equipped with resources for various math courses and standardized tests."
        case "Study Skills Workshops":
            return "Regular workshops cover essential study skills including time management, note-taking, test preparation, and reading strategies. Workshops are designed to help students develop effective learning habits and improve academic performance."
        case "Faculty Advisors":
            return "Faculty advisors provide personalized guidance on academic planning, course selection, and career goals. They help students navigate degree requirements and make informed decisions about their academic journey."
        case "Major Exploration":
            return "The Major Exploration program helps undecided students discover their academic interests and career goals. Services include career assessments, informational interviews, and exploration of different academic fields."
        case "Course Planning":
            return "Academic advisors assist students with course selection and scheduling to ensure timely progress toward degree completion. They help balance academic requirements with personal commitments."
        case "Degree Progress":
            return "The Degree Progress service helps students track their academic progress and ensure they meet all graduation requirements. Advisors review degree audits and help plan remaining coursework."
        case "Accommodations":
            return "Disability Services provides accommodations for students with documented disabilities. Services are tailored to individual needs and may include extended time on tests, note-taking assistance, or alternative format materials."
        case "Accessibility Resources":
            return "The college provides various assistive technologies and learning aids to support students with disabilities. Resources include screen readers, speech-to-text software, and specialized equipment."
        case "Testing Accommodations":
            return "Students with documented disabilities may receive testing accommodations such as extended time, distraction-reduced environments, or alternative testing formats. Arrangements are made in collaboration with faculty."
        case "Advocacy Support":
            return "Disability Services advocates for students' needs and helps them navigate academic accommodations. Staff work with students, faculty, and staff to ensure equal access to education."
        case "Academic Coaching":
            return "Academic coaches work one-on-one with students to develop personalized success strategies. Coaching focuses on study skills, time management, and overcoming academic challenges."
        case "Time Management":
            return "Time management services help students develop effective planning and organization skills. Resources include planners, digital tools, and strategies for balancing academic and personal commitments."
        case "Goal Setting":
            return "The Goal Setting program helps students establish and achieve academic and personal goals. Services include individual consultations and workshops on goal development and achievement."
        case "Success Workshops":
            return "Regular workshops cover topics essential for academic success, including study skills, stress management, and academic planning. Workshops are open to all students and provide practical strategies for success."
        default:
            return "This service provides support for academic success. Please contact the appropriate office for more information."
        }
    }
    
    private func getServiceContact(_ serviceName: String) -> String? {
        switch serviceName {
        case "Tutoring Services", "Writing Center", "Math Lab", "Study Skills Workshops":
            return "Center for Academic Excellence\nLocation: Lougheed Library, Room 101\nPhone: (845) 398-4100\nEmail: cae@stac.edu"
        case "Faculty Advisors", "Major Exploration", "Course Planning", "Degree Progress":
            return "Academic Advising Office\nLocation: Spellman Hall, Room 201\nPhone: (845) 398-4200\nEmail: advising@stac.edu"
        case "Accommodations", "Accessibility Resources", "Testing Accommodations", "Advocacy Support":
            return "Disability Services\nLocation: Spellman Hall, Room 102\nPhone: (845) 398-4300\nEmail: disability@stac.edu"
        case "Academic Coaching", "Time Management", "Goal Setting", "Success Workshops":
            return "Office of Student Success\nLocation: Romano Student Center, Room 301\nPhone: (845) 398-4400\nEmail: success@stac.edu"
        default:
            return nil
        }
    }
}
