import SwiftUI

struct PaymentCompletePassenger: View {
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            
            ZStack {
                Circle()
                    .stroke(Color(red: 0.197, green: 0.759, blue: 0.309), lineWidth: 4)
                    .frame(width: 48, height: 48)
                    .offset(y: -20)
                
                Image(systemName: "checkmark")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 38, height: 36)
                    .foregroundColor(Color(red: 0.197, green: 0.759, blue: 0.309))
                    .offset(y: -20)
            }
            
            Text("All Set!")
                .font(.system(size: 20, weight: .semibold, design: .default))
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
                .padding(.top, 20)
            
            Text("A receipt has been sent to your email")
                .font(.system(size: 16, weight: .medium, design: .default))
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
                .padding(.top, 10)
            
            Spacer()
            
            Button(action: {}) {
                Text("Okay")
                    .font(.system(size: 12, weight: .semibold, design: .default))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, maxHeight: 42)
                    .background(Color(red: 0.467, green: 0, blue: 1))
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 4)
            }
            .frame(width: 222)
            .padding(.bottom, 20)
        }
        .frame(width: 393, height: 852)
        .background(Color.white)
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    PaymentCompletePassenger()
}

