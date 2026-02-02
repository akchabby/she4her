import SwiftUI

struct ProfilePassenger: View {
    @State private var allowKids = false
    @State private var allowPets = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: .spacing24) {
                    // Header
                    headerView
                    
                    // Profile Info Card
                    profileInfoCard
                    
                    // Favorites Section
                    favoritesSection
                    
                    // Preferences Section
                    preferencesSection
                    
                    // Payment & Settings Section
                    paymentSettingsSection
                }
                .padding(.horizontal, .spacing20)
                .padding(.top, .spacing16)
            }
            .background(Color.backgroundPrimary)
        }
        .navigationBarHidden(true)
    }
    
    // MARK: - Header
    private var headerView: some View {
        HStack {
            Button(action: {
                dismiss()
            }) {
                Image(systemName: "arrow.left")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.textPrimary)
                    .frame(width: 44, height: 44)
            }
            
            Spacer()
            
            NavigationLink(destination: MenuPassenger()) {
                Image(systemName: "line.3.horizontal")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.textPrimary)
                    .frame(width: 44, height: 44)
            }
        }
    }
    
    // MARK: - Profile Info Card
    private var profileInfoCard: some View {
        VStack(alignment: .leading, spacing: .spacing16) {
            Text("Profile")
                .font(.headerLarge)
                .foregroundColor(.textPrimary)
            
            HStack(spacing: .spacing16) {
                VStack(alignment: .leading, spacing: .spacing8) {
                    Text("Name")
                        .font(.bodyMedium)
                        .foregroundColor(.textPrimary)
                    
                    Text("Monica Hedge")
                        .font(.bodyLarge)
                        .foregroundColor(.textSecondary)
                }
                
                Spacer()
                
                // Profile Image
                Circle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 80, height: 80)
                    .overlay(
                        Image(systemName: "person.fill")
                            .font(.system(size: 36))
                            .foregroundColor(.white)
                    )
                    .overlay(
                        Circle()
                            .stroke(Color.brandPurple, lineWidth: 2)
                    )
            }
        }
        .padding(.spacing20)
        .background(
            RoundedRectangle(cornerRadius: .radiusLarge)
                .fill(Color.white)
                .cardShadow()
        )
    }
    
    // MARK: - Favorites Section
    private var favoritesSection: some View {
        VStack(alignment: .leading, spacing: .spacing12) {
            HStack {
                Text("My Favorites")
                    .font(.bodyLarge)
                    .foregroundColor(.brandPurple)
                
                Spacer()
                
                NavigationLink(destination: FavoriteDriversPassenger()) {
                    Text("Edit")
                        .font(.buttonSmall)
                        .foregroundColor(.white)
                        .padding(.horizontal, .spacing16)
                        .padding(.vertical, .spacing8)
                        .background(Color.brandPurple)
                        .cornerRadius(.radiusSmall)
                        .buttonShadow()
                }
            }
            
            Text("Manage your favorite drivers")
                .font(.bodySmall)
                .foregroundColor(.textSecondary)
        }
        .padding(.spacing20)
        .background(
            RoundedRectangle(cornerRadius: .radiusLarge)
                .fill(Color.white)
                .cardShadow()
        )
    }
    
    // MARK: - Preferences Section
    private var preferencesSection: some View {
        VStack(alignment: .leading, spacing: .spacing16) {
            Text("Ride Preferences")
                .font(.headerSmall)
                .foregroundColor(.textPrimary)
            
            VStack(spacing: .spacing12) {
                PreferenceRow(title: "Kids", isOn: $allowKids)
                Divider()
                PreferenceRow(title: "Pets", isOn: $allowPets)
            }
        }
        .padding(.spacing20)
        .background(
            RoundedRectangle(cornerRadius: .radiusLarge)
                .fill(Color.white)
                .cardShadow()
        )
    }
    
    // MARK: - Payment & Settings Section
    private var paymentSettingsSection: some View {
        VStack(alignment: .leading, spacing: .spacing16) {
            Text("Account")
                .font(.headerSmall)
                .foregroundColor(.textPrimary)
            
            VStack(spacing: .spacing12) {
                SettingsLink(
                    icon: "creditcard.fill",
                    title: "Cards & Payments",
                    destination: AnyView(EditingPaymentMethod1Passenger())
                )
                
                Divider()
                
                SettingsLink(
                    icon: "gearshape.fill",
                    title: "Account Settings",
                    destination: AnyView(SettingsPassengerView())
                )
                
                Divider()
                
                SettingsLink(
                    icon: "person.2.fill",
                    title: "Emergency Contacts",
                    destination: AnyView(EmergencyContactsPassenger())
                )
            }
        }
        .padding(.spacing20)
        .background(
            RoundedRectangle(cornerRadius: .radiusLarge)
                .fill(Color.white)
                .cardShadow()
        )
    }
}

// MARK: - Preference Row Component
struct PreferenceRow: View {
    let title: String
    @Binding var isOn: Bool
    
    var body: some View {
        HStack {
            Text(title)
                .font(.bodyLarge)
                .foregroundColor(.textPrimary)
            
            Spacer()
            
            Toggle("", isOn: $isOn)
                .labelsHidden()
                .tint(.brandPurple)
        }
    }
}

// MARK: - Settings Link Component
struct SettingsLink: View {
    let icon: String
    let title: String
    let destination: AnyView
    
    var body: some View {
        NavigationLink(destination: destination) {
            HStack(spacing: .spacing12) {
                Image(systemName: icon)
                    .font(.system(size: 20))
                    .foregroundColor(.brandPurple)
                    .frame(width: 32)
                
                Text(title)
                    .font(.bodyLarge)
                    .foregroundColor(.textPrimary)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.textSecondary)
            }
        }
    }
}

#Preview {
    ProfilePassenger()
}
