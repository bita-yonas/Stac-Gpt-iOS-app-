import SwiftUI

struct LaunchScreen: View {
    @State private var animateGlow = false
    @State private var rotateIcon = false
    @State private var showText = false
    @State private var showProgressBar = false
    @State private var progressValue: CGFloat = 0.0
    
    // STAC College Colors
    private let stacGold = Color(red: 0.933, green: 0.733, blue: 0.227) // #EE BB 3A - exact gold from website
    private let stacMaroon = Color(red: 0.535, green: 0.125, blue: 0.204) // #882033 - exact maroon from website
    private let stacBrown = Color(red: 0.41, green: 0.275, blue: 0.2) // #694633
    private let stacBlue = Color(red: 0.082, green: 0.106, blue: 0.173) // #151B2C
    private let stacBlue2 = Color(red: 0.149, green: 0.22, blue: 0.318) // #263851
    
    var body: some View {
        ZStack {
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
            
            // Content
            VStack {
                Spacer()
                
                VStack(spacing: 40) {
                    // Logo animation
                    ZStack {
                        // Outer glow
                        Circle()
                            .fill(
                                RadialGradient(
                                    gradient: Gradient(colors: [
                                        stacGold.opacity(0.7),
                                        stacGold.opacity(0.0)
                                    ]),
                                    center: .center,
                                    startRadius: 50,
                                    endRadius: 140
                                )
                            )
                            .frame(width: 260, height: 260)
                            .scaleEffect(animateGlow ? 1.0 : 0.8)
                            .opacity(animateGlow ? 0.7 : 0.2)
                            .blur(radius: 20)
                            .animation(
                                Animation.easeInOut(duration: 3.0)
                                    .repeatForever(autoreverses: true),
                                value: animateGlow
                            )
                        
                        // Middle glow
                        Circle()
                            .fill(stacBrown.opacity(0.3))
                            .frame(width: 200, height: 200)
                            .blur(radius: 15)
                            .scaleEffect(animateGlow ? 0.9 : 1.1)
                            .animation(
                                Animation.easeInOut(duration: 2.5)
                                    .repeatForever(autoreverses: true)
                                    .delay(0.5),
                                value: animateGlow
                            )
                        
                        // Inner circle
                        Circle()
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [
                                        stacMaroon,
                                        stacMaroon.opacity(0.8)
                                    ]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(width: 160, height: 160)
                            .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 5)
                        
                        // Icon
                        Image("SpartanLogo")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(stacGold)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 90, height: 90)
                            .rotationEffect(.degrees(rotateIcon ? 360 : 0))
                            .animation(
                                Animation.linear(duration: 20)
                                    .repeatForever(autoreverses: false),
                                value: rotateIcon
                            )
                            .overlay(
                                Circle()
                                    .stroke(
                                        LinearGradient(
                                            gradient: Gradient(colors: [.clear, stacGold, .clear]),
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        ),
                                        lineWidth: 1
                                    )
                                    .frame(width: 110, height: 110)
                                    .rotationEffect(.degrees(rotateIcon ? -360 : 0))
                                    .animation(
                                        Animation.linear(duration: 10)
                                            .repeatForever(autoreverses: false),
                                        value: rotateIcon
                                    )
                            )
                    }
                    
                    // Text animation
                    VStack(spacing: 15) {
                        Text("StacGPT")
                            .font(.system(size: 42, weight: .bold))
                            .foregroundColor(stacGold)
                            .opacity(showText ? 1 : 0)
                            .animation(.easeIn(duration: 1.0).delay(0.5), value: showText)
                        
                        Text("Your Educational Assistant")
                            .font(.title3)
                            .foregroundColor(.white.opacity(0.8))
                            .opacity(showText ? 1 : 0)
                            .animation(.easeIn(duration: 1.0).delay(0.8), value: showText)
                    }
                }
                
                Spacer()
                
                // Custom Progress Bar
                VStack(spacing: 15) {
                    // Progressive loading bar
                    ZStack(alignment: .leading) {
                        // Background bar
                        RoundedRectangle(cornerRadius: 12)
                            .frame(width: 200, height: 6)
                            .foregroundColor(stacMaroon.opacity(0.5))
                        
                        // Progress bar
                        RoundedRectangle(cornerRadius: 12)
                            .frame(width: 200 * progressValue, height: 6)
                            .foregroundColor(stacGold)
                    }
                    .opacity(showProgressBar ? 1 : 0)
                    .animation(.easeIn(duration: 0.5), value: showProgressBar)
                    
                    Text("© 2023 StacGPT")
                        .font(.caption)
                        .foregroundColor(stacGold.opacity(0.8))
                        .padding(.bottom)
                        .opacity(showText ? 1 : 0)
                        .animation(.easeIn(duration: 1.0).delay(1.0), value: showText)
                }
                .padding(.bottom, 40)
            }
            .padding()
            .onAppear {
                // Start animations
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    withAnimation {
                        animateGlow = true
                        rotateIcon = true
                        showText = true
                        showProgressBar = true
                    }
                    
                    // Animate progress bar
                    Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { timer in
                        withAnimation {
                            progressValue += 0.01
                        }
                        
                        if progressValue >= 1.0 {
                            timer.invalidate()
                        }
                    }
                }
            }
        }
    }
}

