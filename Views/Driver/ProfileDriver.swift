import SwiftUI

struct ProfileDriverView: View {
    @State private var allowKids = true
    @State private var allowPartners = true
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
                    
                    // License Section
                    licenseSection
                    
                    // Vehicle Section
                    vehicleSection
                    
                    // Vehicle Actions
                    vehicleActionsSection
                    
                    // Payment Section
                    paymentSection
                    
                    // Account Section
                    accountSection
                }
                .padding(.horizontal, .spacing20)
                .padding(.top, .spacing16)
                .padding(.bottom, .spacing32)
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
            
            NavigationLink(destination: MenuDriver()) {
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
                    
                    Text("Jane Dot")
                        .font(.bodyLarge)
                        .foregroundColor(.textSecondary)
                    
                    Text("License Plate")
                        .font(.bodyMedium)
                        .foregroundColor(.textPrimary)
                        .padding(.top, .spacing8)
                    
                    Text("Y45-MD6")
                        .font(.bodyLarge)
                        .foregroundColor(.textSecondary)
                }
                
                Spacer()
                
                // Profile Image
                Circle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 90, height: 90)
                    .overlay(
                        Image(systemName: "person.fill")
                            .font(.system(size: 40))
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
    
    // MARK: - License Section
    private var licenseSection: some View {
        HStack {
            VStack(alignment: .leading, spacing: .spacing4) {
                Text("Driver's License")
                    .font(.bodyLarge)
                    .foregroundColor(.textPrimary)
                
                Text("Verified")
                    .font(.bodySmall)
                    .foregroundColor(.brandGreen)
            }
            
            Spacer()
            
            NavigationLink(destination: EditingLicenseDriverView()) {
                Text("View")
                    .font(.buttonSmall)
                    .foregroundColor(.brandPurple)
                    .padding(.horizontal, .spacing16)
                    .padding(.vertical, .spacing8)
                    .background(
                        RoundedRectangle(cornerRadius: .radiusSmall)
                            .stroke(Color.brandPurple, lineWidth: 1.5)
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
    
    // MARK: - Vehicle Section
    private var vehicleSection: some View {
        VStack(alignment: .leading, spacing: .spacing16) {
            Text("Vehicle")
                .font(.headerSmall)
                .foregroundColor(.textPrimary)
            
            HStack(alignment: .top, spacing: .spacing16) {
                // Left: Vehicle details
                VStack(alignment: .leading, spacing: .spacing12) {
                    HStack {
                        Text("Type:")
                            .font(.bodyMedium)
                            .foregroundColor(.textPrimary)
                        Text("SUV")
                            .font(.bodyMedium)
                            .foregroundColor(.textSecondary)
                    }
                    
                    VStack(alignment: .leading, spacing: .spacing8) {
                        PreferenceRow(title: "Kids", isOn: $allowKids)
                        PreferenceRow(title: "Partners", isOn: $allowPartners)
                        PreferenceRow(title: "Pets", isOn: $allowPets)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                // Right: Vehicle image and stats
                VStack(spacing: .spacing8) {
                    Image(systemName: "car.fill")
                        .font(.system(size: 48))
                        .foregroundColor(.brandPurple)
                        .frame(width: 100, height: 60)
                    
                    VStack(spacing: .spacing4) {
                        Text("Total Miles")
                            .font(.system(size: 10))
                            .foregroundColor(.textSecondary)
                        Text("290")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.brandPurple)
                    }
                }
            }
        }
        .padding(.spacing20)
        .background(
            RoundedRectangle(cornerRadius: .radiusLarge)
                .fill(Color.white)
                .cardShadow()
        )
    }
    
    // MARK: - Vehicle Actions Section
    private var vehicleActionsSection: some View {
        VStack(spacing: .spacing12) {
            NavigationLink(destination: AddingVehicleDriver()) {
                HStack {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(.brandPurple)
                    Text("Add New Vehicle")
                        .font(.bodyLarge)
                        .foregroundColor(.brandPurple)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .font(.system(size: 14))
                        .foregroundColor(.textSecondary)
                }
                .padding(.spacing16)
                .background(
                    RoundedRectangle(cornerRadius: .radiusLarge)
                        .fill(Color.white)
                        .cardShadow()
                )
            }
            
            NavigationLink(destination: DeleteVehicleDriver()) {
                HStack {
                    Image(systemName: "trash.circle.fill")
                        .foregroundColor(.brandRed)
                    Text("Delete Vehicle")
                        .font(.bodyLarge)
                        .foregroundColor(.brandRed)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .font(.system(size: 14))
                        .foregroundColor(.textSecondary)
                }
                .padding(.spacing16)
                .background(
                    RoundedRectangle(cornerRadius: .radiusLarge)
                        .fill(Color.white)
                        .cardShadow()
                )
            }
        }
    }
    
    // MARK: - Payment Section
    private var paymentSection: some View {
        VStack(alignment: .leading, spacing: .spacing16) {
            Text("Payment")
                .font(.headerSmall)
                .foregroundColor(.textPrimary)
            
            VStack(spacing: .spacing12) {
                SettingsLink(
                    icon: "creditcard.fill",
                    title: "Cards & Payments",
                    destination: AnyView(PaymentProfileDriver())
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
    
    // MARK: - Account Section
    private var accountSection: some View {
        VStack(alignment: .leading, spacing: .spacing16) {
            Text("Account")
                .font(.headerSmall)
                .foregroundColor(.textPrimary)
            
            VStack(spacing: .spacing12) {
                SettingsLink(
                    icon: "gearshape.fill",
                    title: "Account Settings",
                    destination: AnyView(SettingsDriver())
                )
                
                Divider()
                
                SettingsLink(
                    icon: "person.2.fill",
                    title: "Emergency Contacts",
                    destination: AnyView(EmergencyContactsDriver())
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

#Preview {
    ProfileDriverView()
}
