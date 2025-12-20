import SwiftUI

struct UpdatingLicensePassenger: View {
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Button(action: {}) {
                        Image(systemName: "arrow.left")
                            .foregroundColor(.black)
                            .frame(width: 48, height: 48)
                    }
                    Spacer()
                }
                .padding(.top, 41)
                .padding(.leading, 22)
                
                Text("My License")
                    .font(.custom("Inter-SemiBold", size: 16))
                    .foregroundColor(.black)
                    .padding(.top, 23)
                    .padding(.leading, 40)
                
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color(red: 0.851, green: 0.851, blue: 0.851), lineWidth: 2)
                    .frame(width: 322, height: 314)
                    .background(Color.white)
                    .overlay(
                        VStack {
                            Image("driversLicenseExample")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 271, height: 172)
                                .cornerRadius(0)
                            
                            Spacer()
                            
                            Button(action: {}) {
                                Text("Update")
                                    .font(.custom("Inter-Medium", size: 15))
                                    .foregroundColor(.white)
                                    .frame(width: 100, height: 37)
                                    .background(Color(red: 0.467, green: 0, blue: 1))
                                    .cornerRadius(5)
                                    .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
                            }
                            .padding(.bottom, 20)
                        }
                    )
                    .padding(.top, 26)
                    .padding(.horizontal, 32)
                
                Spacer()
            }
        }
    }
}

#Preview {
    UpdatingLicensePassenger()
}
