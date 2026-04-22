import SwiftUI

struct MenuPassenger: View {
    @Environment(\.dismiss) private var dismiss
    @AppStorage("isSignedIn") private var isSignedIn = true
    @State private var selectedItem: String = "Payments"
    @State private var showLogoutAlert = false
    @State private var navigateToSignIn = false
    
    var body: some View {
        ZStack {
            // Hidden navigation to SignIn
            NavigationLink(destination: SignIn(), isActive: $navigateToSignIn) {
                EmptyView()
            }
            .hidden()
            
            // Semi-transparent backdrop
            Color.black.opacity(0.2)
                .ignoresSafeArea()
                .onTapGesture {
                    dismiss()
                }
            
            ZStack {
                // Centered Menu Card
                VStack(spacing: 0) {
                    // Close Button
                    HStack {
                        Spacer()
                        Button(action: {
                            dismiss()
                        }) {
                            Image(systemName: "xmark")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(Color(red: 0.61, green: 0.35, blue: 0.71)) // Purple
                                .frame(width: 40, height: 40)
                        }
                        .padding(.trailing, 20)
                        .padding(.top, 16)
                    }
                    
                    // Menu Items
                    VStack(spacing: 8) {
                        MenuPassengerItem(
                            icon: "person.fill",
                            title: "Profile",
                            iconColor: .white,
                            iconBackgroundColor: Color(red: 0.61, green: 0.35, blue: 0.71), // Purple
                            textColor: .black,
                            isSelected: selectedItem == "Profile",
                            destination: AnyView(ProfilePassenger())
                        )
                        .onTapGesture {
                            selectedItem = "Profile"
                        }
                        
                        MenuPassengerItem(
                            icon: "dollarsign",
                            title: "Payments",
                            iconColor: .white,
                            iconBackgroundColor: Color(red: 0.61, green: 0.35, blue: 0.71), // Purple
                            textColor: .black,
                            isSelected: selectedItem == "Payments",
                            destination: AnyView(PaymentProfilePassenger())
                        )
                        .onTapGesture {
                            selectedItem = "Payments"
                        }
                        
                        MenuPassengerItem(
                            icon: "gearshape.fill",
                            title: "Settings",
                            iconColor: .white,
                            iconBackgroundColor: Color(red: 0.61, green: 0.35, blue: 0.71), // Purple
                            textColor: .black,
                            isSelected: selectedItem == "Settings",
                            destination: AnyView(SettingsPassengerView())
                        )
                        .onTapGesture {
                            selectedItem = "Settings"
                        }
                        
                        NavigationLink(destination: SafetyPagePassenger()) {
                            MenuPassengerItem(
                                icon: "exclamationmark.triangle.fill",
                                title: "Safety",
                                iconColor: .white,
                                iconBackgroundColor: Color.red,
                                textColor: .red,
                                isSelected: selectedItem == "Safety",
                                destination: AnyView(SafetyPagePassenger())
                            )
                        }
                        .simultaneousGesture(TapGesture().onEnded {
                            selectedItem = "Safety"
                        })
                        
                        // Log Out Button
                        Button(action: {
                            showLogoutAlert = true
                        }) {
                            MenuPassengerLogoutItem(
                                icon: "rectangle.portrait.and.arrow.right",
                                title: "Log Out",
                                iconColor: .white,
                                iconBackgroundColor: Color(red: 0.61, green: 0.35, blue: 0.71), // Purple
                                textColor: Color(red: 0.61, green: 0.35, blue: 0.71),
                                isSelected: selectedItem == "Log Out"
                            )
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 8)
                    .padding(.bottom, 32)
                }
                .background(
                    RoundedRectangle(cornerRadius: 24)
                        .fill(Color.white)
                        .shadow(color: .black.opacity(0.15), radius: 20, x: 0, y: 4)
                )
                .frame(maxWidth: 340)
                .padding(.horizontal, 20)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
        .alert("Log Out", isPresented: $showLogoutAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Log Out", role: .destructive) {
                handleLogout()
            }
        } message: {
            Text("Are you sure you want to log out?")
        }
    }
    
    private func handleLogout() {
        print("Logging out...")
        
        // Clear user session by setting isSignedIn to false
        isSignedIn = false
        
        // Dismiss the menu
        dismiss()
        
        // Navigate to SignIn
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            navigateToSignIn = true
        }
    }
}

// Regular Menu Item with Navigation
struct MenuPassengerItem: View {
    let icon: String
    let title: String
    let iconColor: Color
    let iconBackgroundColor: Color
    let textColor: Color
    let isSelected: Bool
    let destination: AnyView
    
    var body: some View {
        NavigationLink(destination: destination) {
            HStack(spacing: 16) {
                // Icon Container
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(iconBackgroundColor)
                        .frame(width: 42, height: 42)
                    
                    Image(systemName: icon)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(iconColor)
                }
                
                // Title
                Text(title)
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(textColor)
                
                Spacer()
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 10)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(isSelected ? Color(red: 0.93, green: 0.87, blue: 0.96) : Color.clear)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(isSelected ? Color(red: 0.61, green: 0.35, blue: 0.71) : Color.clear, lineWidth: 2)
                    )
            )
        }
    }
}

// Logout Item (no navigation, just action)
struct MenuPassengerLogoutItem: View {
    let icon: String
    let title: String
    let iconColor: Color
    let iconBackgroundColor: Color
    let textColor: Color
    let isSelected: Bool
    
    var body: some View {
        HStack(spacing: 16) {
            // Icon Container
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(iconBackgroundColor)
                    .frame(width: 42, height: 42)
                
                Image(systemName: icon)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(iconColor)
            }
            
            // Title
            Text(title)
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(textColor)
            
            Spacer()
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 10)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(isSelected ? Color(red: 0.93, green: 0.87, blue: 0.96) : Color.clear)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(isSelected ? Color(red: 0.61, green: 0.35, blue: 0.71) : Color.clear, lineWidth: 2)
                )
        )
    }
}

#Preview {
    MenuPassenger()
}
