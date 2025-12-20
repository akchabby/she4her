import SwiftUI

struct MenuPassenger: View {
    var body: some View {
        ZStack {
            Color.white
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.white)
                        .frame(width: 328, height: 420)
                        .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 4)
                    
                    VStack(alignment: .leading, spacing: 28) {
                        NavigationLink(destination: ProfilePassenger()) {
                            HStack {
                                Image(systemName: "person")
                                    .resizable()
                                    .frame(width: 32, height: 32)
                                    .foregroundColor(.black)
                                
                                Text("Profile")
                                    .font(.system(size: 28, weight: .semibold))
                            }
                        }
                        .buttonStyle(.plain)
                        
                        NavigationLink(destination: PaymentProfilePassenger()) {
                            HStack {
                                Image(systemName: "dollarsign")
                                    .resizable()
                                    .frame(width: 25, height: 32)
                                    .foregroundColor(.black)
                                Text("Payments")
                                    .font(.system(size: 28, weight: .semibold))
                            }
                        }
                        .buttonStyle(.plain)
                        NavigationLink(destination: SettingsPassengerView()){
                            HStack {
                                Image(systemName: "gear")
                                    .resizable()
                                    .frame(width: 32, height: 32)
                                    .foregroundColor(.black)
                                Text("Settings")
                                    .font(.system(size: 28, weight: .semibold))
                            }
                        }
                        NavigationLink(destination: SafetyPagePassenger()) {
                            HStack {
                                Image(systemName: "exclamationmark.triangle")
                                    .resizable()
                                    .frame(width: 32, height: 32)
                                    .foregroundColor(.red)
                                Text("Safety")
                                    .font(.system(size: 28, weight: .semibold))
                            }
                        }
                    }
                    .padding(.top, 20)
                }
                
                Spacer()
            }
            
            VStack {
                HStack {
                    Spacer()
                    PassengerCloseButton()
                        .padding(.trailing, 45)
                        .padding(.top, 21)
                }
                Spacer()
            }
        }
    }
}

struct PassengerMenuItem: View {
    var iconName: String
    var title: String
    
    var body: some View {
        HStack {
            Image(systemName: iconName)
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor(Color.black.opacity(0.9))
            
            Text(title)
                .font(.system(size: 24, weight: .medium))
                .foregroundColor(.black)
                .padding(.leading, 5)
            
            Spacer()
        }
        .frame(width: 178, height: 29)
    }
}

struct PassengerCloseButton: View {
    var body: some View {
        Image(systemName: "xmark")
            .resizable()
            .frame(width: 16, height: 16)
            .foregroundColor(Color.black.opacity(0.9))
            .padding()
            .background(Color.white)
            .clipShape(Circle())
            .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 4)
    }
}

#Preview {
    MenuPassenger()
}

