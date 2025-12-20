import SwiftUI

struct ProfilePassenger: View {
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Button(action: {
                    }) {
                        Image(systemName: "arrow.left")
                            .foregroundColor(.black)
                            .frame(width: 48, height: 48)
                    }
                    
                    Spacer()
                    
                    Button(action: {}) {
                        Image(systemName: "line.3.horizontal")
                            .foregroundColor(.black)
                            .frame(width: 48, height: 48)
                    }
                }
                .padding(.horizontal, 22)
                .padding(.top, 41)
                
                Text("Profile")
                    .font(.system(size: 24, weight: .medium))
                    .padding(.horizontal, 32)
                    .padding(.top, 12)
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("Name")
                            .font(.system(size: 16, weight: .medium))
                        Text("Monica Hedge")
                            .font(.system(size: 16, weight: .medium))
                            .opacity(0.37)
                    }
                    
                    Spacer()
                    
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 111, height: 105)
                        .clipShape(Circle())
                }
                .padding(.horizontal, 32)
                .padding(.top, 47)
                
                Text("My Favorites")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.purple)
                    .padding(.horizontal, 32)
                    .padding(.top, 12)
                
                Button(action: {}) {
                    HStack {
                        Text("Edit")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundColor(.white)
                    }
                    .frame(width: 84, height: 35)
                    .background(Color.purple)
                    .cornerRadius(5)
                    .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
                }
                .padding(.horizontal, 32)
                .padding(.top, 12)
                
                VStack(alignment: .leading, spacing: 16) {
                    Text("Preferences")
                        .font(.system(size: 24, weight: .medium))
                    
                    HStack {
                        Text("Kids")
                            .font(.system(size: 16, weight: .medium))
                        
                        Spacer()
                        
                        Toggle("", isOn: .constant(false))
                    }
                    
                    HStack {
                        Text("Pets")
                            .font(.system(size: 16, weight: .medium))
                        
                        Spacer()
                        
                        Toggle("", isOn: .constant(false))
                    }
                }
                .padding(.horizontal, 32)
                .padding(.top, 24)
                
                VStack(alignment: .leading, spacing: 16) {
                    Text("Payment")
                        .font(.system(size: 24, weight: .medium))
                    
                    // Cards & Payments
                    NavigationLink(destination: EditingPaymentMethod1Passenger()) {
                        Text("Cards & Payments")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.purple)
                    }
                    
                    // Account Settings
                    NavigationLink(destination: SettingsPassengerView()) {
                        Text("Account Settings")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.purple)
                    }
                    
                    // Emergency Contacts
                    NavigationLink(destination: EmergencyContactsPassenger()) {
                        Text("Emergency Contacts")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.purple)
                    }
                }
                .padding(.horizontal, 32)
                .padding(.top, 24)
                
                Spacer()
            }
        }
    }
}

#Preview {
    ProfilePassenger()
}
