import SwiftUI

struct ShareYourThoughtsDriver: View {
    var body: some View {
        ZStack {
            Color.white
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                Spacer().frame(height: 95)
                
                Rectangle()
                    .fill(Color(#colorLiteral(red: 0.4666637182235718, green: 0, blue: 1, alpha: 1)))
                    .frame(width: 167, height: 145)
                    .background(Color(#colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)))
                
                Spacer().frame(height: 41)
                
                Text("Share Your Thoughts!")
                    .font(.system(size: 16, weight: .semibold, design: .default))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                
                Spacer().frame(height: 6)
                
                Text("Help us make She4Her even better!")
                    .font(.system(size: 12, weight: .regular, design: .default))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                
                Spacer().frame(height: 81)
                
                HStack {
                    Group {
                        Ellipse()
                            .fill(Color.white)
                            .frame(width: 50, height: 48)
                            .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 4)
                        
                        Image(systemName: "star.fill")
                            .resizable()
                            .frame(width: 28, height: 28)
                            .foregroundColor(Color(#colorLiteral(red: 0.4666637182235718, green: 0, blue: 1, alpha: 1)))
                    }
                    
                    Spacer().frame(width: 29)
                    
                    Text("Rate Driver")
                        .font(.system(size: 16, weight: .semibold, design: .default))
                        .foregroundColor(.black)
                    
                    Spacer()
                }
                .padding(.leading, 63)
                
                Spacer().frame(height: 79)
                
                HStack {
                    Group {
                        Ellipse()
                            .fill(Color.white)
                            .frame(width: 50, height: 48)
                            .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 4)
                        
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .frame(width: 28, height: 28)
                            .foregroundColor(Color(#colorLiteral(red: 0.4666637182235718, green: 0, blue: 1, alpha: 1)))
                    }
                    
                    Spacer().frame(width: 29)
                    
                    Text("Block Driver")
                        .font(.system(size: 16, weight: .semibold, design: .default))
                        .foregroundColor(.black)
                    
                    Spacer()
                }
                .padding(.leading, 60)
                
                Spacer().frame(height: 202)
                
                ZStack {
                    Rectangle()
                        .fill(Color(#colorLiteral(red: 0.4666637182235718, green: 0, blue: 1, alpha: 1)))
                        .frame(width: 222, height: 43.373046875)
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 4)
                    
                    Text("Skip")
                        .font(.system(size: 16, weight: .semibold, design: .default))
                        .foregroundColor(.white)
                }
                .padding(.leading, 86)
            }
        }
    }
}

#Preview {
    ShareYourThoughtsDriver()
}
