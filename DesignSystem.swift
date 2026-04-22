import SwiftUI

// MARK: - Brand Colors
extension Color {
    // Primary Brand Colors
    static let brandPurple = Color(red: 0.467, green: 0, blue: 1) // #7700FF
    static let brandGreen = Color(red: 0.197, green: 0.76, blue: 0.31)
    static let brandRed = Color(red: 0.9, green: 0.2, blue: 0.2)
    
    // Text Colors
    static let textPrimary = Color.black
    static let textSecondary = Color.black.opacity(0.44)
    static let textTertiary = Color.black.opacity(0.37)
    
    // Background Colors
    static let backgroundPrimary = Color.white
    static let backgroundSecondary = Color(white: 0.96)
    static let backgroundCard = Color.white
    
    // Border Colors
    static let borderLight = Color.gray.opacity(0.2)
    static let borderMedium = Color.gray.opacity(0.3)
}

// MARK: - Typography
extension Font {
    // Headers
    static let headerLarge = Font.system(size: 24, weight: .medium)
    static let headerMedium = Font.system(size: 20, weight: .semibold)
    static let headerSmall = Font.system(size: 16, weight: .semibold)
    
    // Body Text
    static let bodyLarge = Font.system(size: 16, weight: .medium)
    static let bodyMedium = Font.system(size: 14, weight: .regular)
    static let bodySmall = Font.system(size: 12, weight: .regular)
    static let bodyExtraSmall = Font.system(size: 11, weight: .regular)
    
    // Buttons
    static let buttonLarge = Font.system(size: 16, weight: .semibold)
    static let buttonMedium = Font.system(size: 14, weight: .semibold)
    static let buttonSmall = Font.system(size: 12, weight: .semibold)
}

// MARK: - Spacing
extension CGFloat {
    static let spacing4: CGFloat = 4
    static let spacing8: CGFloat = 8
    static let spacing12: CGFloat = 12
    static let spacing16: CGFloat = 16
    static let spacing20: CGFloat = 20
    static let spacing24: CGFloat = 24
    static let spacing32: CGFloat = 32
    static let spacing40: CGFloat = 40
    static let spacing48: CGFloat = 48
    static let spacing64: CGFloat = 64
}

// MARK: - Corner Radius
extension CGFloat {
    static let radiusSmall: CGFloat = 5
    static let radiusMedium: CGFloat = 8
    static let radiusLarge: CGFloat = 16
    static let radiusExtraLarge: CGFloat = 24
    static let radiusFull: CGFloat = 999
}

// MARK: - Shadow Styles
extension View {
    func cardShadow() -> some View {
        self.shadow(color: Color.black.opacity(0.08), radius: 12, x: 0, y: 4)
    }
    
    func buttonShadow() -> some View {
        self.shadow(color: Color.black.opacity(0.15), radius: 8, x: 0, y: 4)
    }
    
    func lightShadow() -> some View {
        self.shadow(color: Color.black.opacity(0.1), radius: 6, x: 0, y: 2)
    }
    
    func purpleShadow() -> some View {
        self.shadow(color: Color.brandPurple.opacity(0.35), radius: 6, x: 0, y: 3)
    }
}

// MARK: - Reusable Components

// Primary Button
struct PrimaryButton: View {
    let title: String
    let action: () -> Void
    var isEnabled: Bool = true
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.buttonMedium)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 48)
                .background(isEnabled ? Color.brandPurple : Color.gray)
                .cornerRadius(.radiusMedium)
                .buttonShadow()
        }
        .disabled(!isEnabled)
    }
}

// Secondary Button
struct SecondaryButton: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.buttonMedium)
                .foregroundColor(.brandPurple)
                .frame(maxWidth: .infinity)
                .frame(height: 48)
                .background(Color.white)
                .cornerRadius(.radiusMedium)
                .overlay(
                    RoundedRectangle(cornerRadius: .radiusMedium)
                        .stroke(Color.brandPurple, lineWidth: 2)
                )
                .purpleShadow()
        }
    }
}

// Small Action Button
struct SmallActionButton: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.buttonSmall)
                .foregroundColor(.white)
                .padding(.horizontal, .spacing16)
                .padding(.vertical, .spacing8)
                .background(Color.brandPurple)
                .cornerRadius(.radiusSmall)
                .buttonShadow()
        }
    }
}

// Card Container
struct CardContainer<Content: View>: View {
    let content: Content
    var padding: CGFloat = .spacing20
    
    init(padding: CGFloat = .spacing20, @ViewBuilder content: () -> Content) {
        self.padding = padding
        self.content = content()
    }
    
    var body: some View {
        content
            .padding(padding)
            .background(
                RoundedRectangle(cornerRadius: .radiusLarge)
                    .fill(Color.backgroundCard)
                    .cardShadow()
            )
    }
}

// Search Bar
struct SearchBar: View {
    @Binding var text: String
    let placeholder: String
    
    var body: some View {
        HStack(spacing: .spacing12) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.textSecondary)
                .font(.system(size: 18))
            
            TextField(placeholder, text: $text)
                .font(.bodyLarge)
                .foregroundColor(.textPrimary)
        }
        .padding(.spacing16)
        .background(Color.backgroundSecondary)
        .cornerRadius(.radiusMedium)
    }
}

// Bottom Sheet Container
struct BottomSheetContainer<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack {
                content
            }
            .padding(.spacing20)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: .radiusExtraLarge, style: .continuous)
                    .fill(Color.white)
                    .shadow(color: Color.black.opacity(0.08), radius: 12, x: 0, y: -2)
            )
        }
    }
}

// Safety Notice Pill
struct SafetyNoticePill: View {
    let text: String
    
    var body: some View {
        HStack(spacing: .spacing8) {
            Image(systemName: "shield")
                .foregroundColor(.brandPurple)
                .font(.system(size: 16))
            
            Text(text)
                .font(.bodyExtraSmall)
                .foregroundColor(.textPrimary)
        }
        .padding(.vertical, .spacing8)
        .padding(.horizontal, .spacing12)
        .background(
            RoundedRectangle(cornerRadius: 22)
                .fill(Color.white)
                .lightShadow()
        )
    }
}

// Rating Display
struct RatingDisplay: View {
    let rating: Double
    let tripCount: Int
    
    var body: some View {
        HStack(spacing: .spacing8) {
            Text(String(format: "%.1f", rating))
                .font(.bodySmall)
                .foregroundColor(.textSecondary)
            
            Image(systemName: "star.fill")
                .font(.system(size: 10))
                .foregroundColor(.textSecondary)
            
            Text("•")
                .foregroundColor(.textSecondary)
            
            Text("\(tripCount) trips")
                .font(.bodySmall)
                .foregroundColor(.textSecondary)
        }
    }
}

// Driver/Passenger Profile Card
struct ProfileCard: View {
    let name: String
    let rating: Double
    let tripCount: Int
    let vehicleInfo: String?
    let plateNumber: String?
    let showSafetyButton: Bool
    
    init(name: String, rating: Double, tripCount: Int, vehicleInfo: String? = nil, plateNumber: String? = nil, showSafetyButton: Bool = false) {
        self.name = name
        self.rating = rating
        self.tripCount = tripCount
        self.vehicleInfo = vehicleInfo
        self.plateNumber = plateNumber
        self.showSafetyButton = showSafetyButton
    }
    
    var body: some View {
        HStack(spacing: .spacing12) {
            // Profile Image
            Circle()
                .fill(Color.gray.opacity(0.3))
                .frame(width: 50, height: 50)
                .overlay(
                    Image(systemName: "person.fill")
                        .foregroundColor(.white)
                )
            
            // Info
            VStack(alignment: .leading, spacing: .spacing4) {
                Text(name)
                    .font(.bodySmall)
                    .fontWeight(.semibold)
                    .foregroundColor(.brandPurple)
                
                RatingDisplay(rating: rating, tripCount: tripCount)
            }
            
            Spacer()
            
            // Vehicle Info (if provided)
            if let vehicleInfo = vehicleInfo, let plateNumber = plateNumber {
                VStack(alignment: .trailing, spacing: .spacing8) {
                    HStack(spacing: .spacing12) {
                        Text(vehicleInfo)
                            .font(.bodySmall)
                            .foregroundColor(.textPrimary)
                        
                        if showSafetyButton {
                            Image(systemName: "exclamationmark.triangle.fill")
                                .foregroundColor(.brandRed)
                                .font(.system(size: 18))
                        }
                    }
                    
                    Text(plateNumber)
                        .font(.system(size: 15, weight: .medium))
                        .foregroundColor(.textPrimary)
                }
            }
        }
        .padding(.spacing16)
        .background(
            RoundedRectangle(cornerRadius: .radiusLarge)
                .fill(Color.white)
                .lightShadow()
        )
    }
}

// Custom Text Field Style
struct CustomTextField: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(.spacing16)
            .background(Color.backgroundSecondary)
            .cornerRadius(.radiusMedium)
            .font(.bodyMedium)
    }
}

// Loading Indicator
struct LoadingView: View {
    var body: some View {
        VStack(spacing: .spacing16) {
            ProgressView()
                .scaleEffect(1.5)
                .tint(.brandPurple)
            
            Text("Loading...")
                .font(.bodyMedium)
                .foregroundColor(.textSecondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.backgroundPrimary)
    }
}

// Error View
struct ErrorView: View {
    let message: String
    let retryAction: (() -> Void)?
    
    var body: some View {
        VStack(spacing: .spacing20) {
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 48))
                .foregroundColor(.brandRed)
            
            Text(message)
                .font(.bodyLarge)
                .foregroundColor(.textPrimary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, .spacing32)
            
            if let retryAction = retryAction {
                PrimaryButton(title: "Try Again", action: retryAction)
                    .frame(width: 200)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.backgroundPrimary)
    }
}

// Preview Examples
#Preview("Buttons") {
    VStack(spacing: .spacing20) {
        PrimaryButton(title: "Primary Button") {}
        SecondaryButton(title: "Secondary Button") {}
        SmallActionButton(title: "Cancel Ride") {}
    }
    .padding()
}

#Preview("Cards") {
    VStack(spacing: .spacing20) {
        CardContainer {
            VStack(alignment: .leading, spacing: .spacing12) {
                Text("Card Title")
                    .font(.headerSmall)
                Text("This is content inside a card container")
                    .font(.bodyMedium)
                    .foregroundColor(.textSecondary)
            }
        }
        
        SafetyNoticePill(text: "Driver may record audio for added safety.")
        
        ProfileCard(
            name: "Martha",
            rating: 4.9,
            tripCount: 900,
            vehicleInfo: "Jeep Compass",
            plateNumber: "340-WH56",
            showSafetyButton: true
        )
    }
    .padding()
}
