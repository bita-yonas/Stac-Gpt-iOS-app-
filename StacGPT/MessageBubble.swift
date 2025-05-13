import SwiftUI

struct MessageBubble: View {
    var message: ChatMessage
    @State private var animateGlow = false
    
    // STAC College Colors
    var stacGold: Color
    var stacBlue: Color
    var stacBrown: Color
    var stacMaroon: Color
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 15) {
            if message.isFromUser {
                Spacer()
                
                // User message with timestamp
                VStack(alignment: .trailing, spacing: 4) {
                    Text(message.content)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [stacMaroon.opacity(0.9), stacMaroon.opacity(0.7)]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .foregroundColor(.white)
                        .cornerRadius(18)
                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                    
                    Text(formatTime(date: message.date))
                        .font(.caption2)
                        .foregroundColor(.white.opacity(0.7))
                        .padding(.trailing, 8)
                }
                .padding(.leading, 60)
                
                // User avatar with border
                Circle()
                    .fill(stacBlue)
                    .frame(width: 36, height: 36)
                    .overlay(
                        Text(String(message.content.prefix(1).uppercased()))
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.white)
                    )
            } else {
                // Bot avatar with glow
                ZStack {
                    Circle()
                        .fill(stacGold.opacity(0.2))
                        .frame(width: 36, height: 36)
                        .scaleEffect(animateGlow ? 1.2 : 1.0)
                        .opacity(animateGlow ? 0.6 : 0.2)
                        .animation(
                            Animation.easeInOut(duration: 1.5)
                                .repeatForever(autoreverses: true),
                            value: animateGlow
                        )
                        
                    Image("spartan_logo")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(stacGold)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24)
                }
                .onAppear {
                    animateGlow = true
                }
                
                // Bot message
                VStack(alignment: .leading, spacing: 4) {
                    Text(message.content)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
                        .background(Color.white.opacity(0.15))
                        .foregroundColor(.white)
                        .cornerRadius(18)
                    
                    Text(formatTime(date: message.date))
                        .font(.caption2)
                        .foregroundColor(.white.opacity(0.7))
                        .padding(.leading, 8)
                }
                .padding(.trailing, 60)
                
                Spacer()
            }
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
    }
    
    // Format the timestamp
    private func formatTime(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
} 
