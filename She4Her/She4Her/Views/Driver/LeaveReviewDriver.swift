import SwiftUI

struct LeavingAReviewDriver: View {
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
                    .frame(width: 214, height: 18)
                
                Spacer().frame(height: 6)
                
                Text("Help us make She4Her even better!")
                    .font(.system(size: 12, weight: .regular, design: .default))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .frame(width: 217, height: 22)
                
                Spacer().frame(height: 41)
                
                HStack(spacing: 0) {
                    ForEach(0..<4) { _ in
                        Image(systemName: "star.fill")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundColor(Color(#colorLiteral(red: 0.4666637182235718, green: 0, blue: 1, alpha: 1)))
                    }
                    Image(systemName: "star")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundColor(Color(#colorLiteral(red: 0.4666637182235718, green: 0, blue: 1, alpha: 1)))
                }
                .frame(width: 114, height: 24)
                
                Spacer().frame(height: 49)
                
                ZStack {
                    Rectangle()
                        .fill(Color.white)
                        .frame(width: 265, height: 199)
                        .cornerRadius(5)
                        .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 4)
                    
                    Text("Write about your experience!")
                        .font(.system(size: 10, weight: .regular, design: .default))
                        .foregroundColor(Color.black.opacity(0.44))
                        .frame(width: 160, height: 19, alignment: .leading)
                        .padding(.top, 9)
                        .padding(.leading, 16)
                }
                
                Spacer().frame(height: 71)
                
                ZStack {
                    Rectangle()
                        .fill(Color(#colorLiteral(red: 0.4666637182235718, green: 0, blue: 1, alpha: 1)))
                        .frame(width: 222, height: 43.373046875)
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 4)
                    
                    Text("Submit")
                        .font(.system(size: 16, weight: .semibold, design: .default))
                        .foregroundColor(.white)
                        .frame(width: 151.45794677734375, height: 22.095703125)
                }
            }
        }
    }
}

#Preview {
    LeavingAReviewDriver()
}
