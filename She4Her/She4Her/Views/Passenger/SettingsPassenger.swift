import SwiftUI

struct SettingsPassengerView: View {
    var body: some View {
        ZStack {
            Color.white
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.white)
                        .frame(width: 308, height: 332)
                        .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 4)
                    
                    VStack(alignment: .center, spacing: 20) {
                        NavigationLink(destination: ProfilePassenger()) {
                            Text("Edit Profile")
                                .font(.custom("Inter-Medium", size: 20))
                                .foregroundColor(Color(red: 0.4667, green: 0, blue: 1))
                                .frame(width: 158, height: 39, alignment: .center)
                        }
                        .buttonStyle(.plain)
                        
                        NavigationLink(destination: UpdatingLicensePassenger()) {
                            Text("Update License")
                                .font(.custom("Inter-Medium", size: 20))
                                .foregroundColor(Color(red: 0.4667, green: 0, blue: 1))
                                .frame(width: 162, height: 29, alignment: .center)
                        }
                        .buttonStyle(.plain)
                        
                        NavigationLink(destination: DeleteAccountView()) {
                            Text("Delete Account")
                                .font(.custom("Inter-Medium", size: 20))
                                .foregroundColor(Color(red: 0.4667, green: 0, blue: 1))
                                .frame(width: 154, height: 29, alignment: .center)
                        }
                        .buttonStyle(.plain)
                    }
                    .padding(.top, 200)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                }
                .padding(.top, 208)
                
                Spacer()
            }
            
            VStack {
                HStack {
                    Spacer()
                    
                    ZStack {
                        Circle()
                            .fill(Color.clear)
                            .frame(width: 32, height: 32)
                        
                        Image(systemName: "xmark")
                            .resizable()
                            .frame(width: 16, height: 16)
                            .foregroundColor(Color(red: 0.1176, green: 0.1176, blue: 0.1176))
                    }
                    .padding(.trailing, 45)
                    .padding(.top, 234)
                }
                
                Spacer()
            }
        }
    }
}

#Preview {
    SettingsPassengerView()
}
