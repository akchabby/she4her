import SwiftUI

struct DeleteAccountCompletionDriver: View {
    var body: some View {
        VStack {
            HStack {
                Button(action: {}) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.black)
                        .frame(width: 48, height: 48)
                }
                Spacer()
            }
            .padding(.leading, 22)
            .padding(.top, 41)
            
            VStack(spacing: 0) {
                Rectangle()
                    .fill(Color.white)
                    .frame(width: 308, height: 370)
                    .cornerRadius(16)
                    .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 4)
                
                VStack(spacing: 16) {
                    Text("Success!")
                        .font(.system(size: 24, weight: .medium))
                        .foregroundColor(.black)
                        .frame(width: 236, height: 34)
                    
                    Text("Your account has been permanently deleted.")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(.black)
                        .frame(width: 235, height: 42)
                        .multilineTextAlignment(.center)
                }
                .padding(.top, 40)
                
                Button(action: {}) {
                    Text("Continue")
                        .font(.system(size: 15, weight: .medium))
                        .foregroundColor(.white)
                        .frame(width: 117, height: 55)
                        .background(Color(red: 0.467, green: 0, blue: 1))
                        .cornerRadius(5)
                        .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 4)
                }
                .padding(.top, 40)
            }
            .padding(.top, 167)
            
            Spacer()
        }
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    DeleteAccountCompletionDriver()
}
