import SwiftUI

struct MenuDriver: View {
    @Environment(\.dismiss) private var dismiss
    @AppStorage("isSignedIn") private var isSignedIn = false
    @State private var selectedItem: String = "Payments"
    
    var body: some View {
        NavigationStack {
            ZStack {
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
                            MenuDriverItem(
                                icon: "person.fill",
                                title: "Profile",
                                iconColor: .white,
                                iconBackgroundColor: Color(red: 0.61, green: 0.35, blue: 0.71), // Purple
                                textColor: .black,
                                isSelected: selectedItem == "Profile",
                                destination: AnyView(ProfileDriverView())
                            )
                            .onTapGesture {
                                selectedItem = "Profile"
                            }
                            
                            MenuDriverItem(
                                icon: "dollarsign",
                                title: "Payments",
                                iconColor: .white,
                                iconBackgroundColor: Color(red: 0.61, green: 0.35, blue: 0.71), // Purple
                                textColor: .black,
                                isSelected: selectedItem == "Payments",
                                destination: AnyView(PaymentProfileDriver())
                            )
                            .onTapGesture {
                                selectedItem = "Payments"
                            }
                            
                            MenuDriverItem(
                                icon: "gearshape.fill",
                                title: "Settings",
                                iconColor: .white,
                                iconBackgroundColor: Color(red: 0.61, green: 0.35, blue: 0.71), // Purple
                                textColor: .black,
                                isSelected: selectedItem == "Settings",
                                destination: AnyView(SettingsDriver())
                            )
                            .onTapGesture {
                                selectedItem = "Settings"
                            }
                            
                            MenuDriverItem(
                                icon: "exclamationmark.triangle.fill",
                                title: "Safety",
                                iconColor: .white,
                                iconBackgroundColor: Color.red,
                                textColor: .red,
                                isSelected: selectedItem == "Safety",
                                destination: AnyView(SafetyPageDriver())
                            )
                            .onTapGesture {
                                selectedItem = "Safety"
                            }
                            
                            // Log Out Button
                            MenuDriverLogoutItem(
                                icon: "rectangle.portrait.and.arrow.right",
                                title: "Log Out",
                                iconColor: .white,
                                iconBackgroundColor: Color(red: 0.61, green: 0.35, blue: 0.71), // Purple
                                textColor: Color(red: 0.61, green: 0.35, blue: 0.71),
                                isSelected: selectedItem == "Log Out",
                                action: {
                                    selectedItem = "Log Out"
                                    handleLogout()
                                }
                            )
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
            .fullScreenCover(isPresented: .constant(!isSignedIn)) {
                SignIn()
            }
        }
    }
    
    private func handleLogout() {
        // Clear sign-in state
        isSignedIn = false
        
        // Add any additional logout logic here
        print("Logging out driver...")
        
        // Dismiss the menu
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            dismiss()
        }
    }
}

// Regular Menu Item with Navigation
struct MenuDriverItem: View {
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
struct MenuDriverLogoutItem: View {
    let icon: String
    let title: String
    let iconColor: Color
    let iconBackgroundColor: Color
    let textColor: Color
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
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
        .buttonStyle(.plain)
        .contentShape(Rectangle())
        .accessibilityLabel(Text("Log Out"))
    }
}

#Preview {
    MenuDriver()
}
