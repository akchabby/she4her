import SwiftUI

struct FavoriteDriver: Identifiable {
    let id = UUID()
    var name: String
    var rating: Double
    var trips: Int
}

struct FavoriteDriversPassenger: View {
    @State private var favoriteDrivers: [FavoriteDriver] = [
        FavoriteDriver(name: "Connie Nelson", rating: 4.9, trips: 234),
        FavoriteDriver(name: "Nona Carlson", rating: 4.8, trips: 156),
        FavoriteDriver(name: "Justine Appleton", rating: 5.0, trips: 412)
    ]
    @State private var showDeleteAlert = false
    @State private var driverToDelete: FavoriteDriver?
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                headerSection
                
                ScrollView {
                    VStack(spacing: 16) {
                        if favoriteDrivers.isEmpty {
                            emptyStateView
                        } else {
                            ForEach(favoriteDrivers) { driver in
                                DriverCard(
                                    driver: driver,
                                    onDelete: {
                                        driverToDelete = driver
                                        showDeleteAlert = true
                                    }
                                )
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                    .padding(.bottom, 40)
                }
            }
            .background(Color(red: 0.98, green: 0.98, blue: 0.98))
            .navigationBarBackButtonHidden(true)
        }
        .alert("Remove Favorite Driver", isPresented: $showDeleteAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Remove", role: .destructive) {
                if let driver = driverToDelete {
                    favoriteDrivers.removeAll { $0.id == driver.id }
                }
            }
        } message: {
            if let driver = driverToDelete {
                Text("Remove \(driver.name) from your favorite drivers?")
            }
        }
    }
    
    // MARK: - Header Section
    private var headerSection: some View {
        HStack {
            Button(action: {
                dismiss()
            }) {
                HStack(spacing: 8) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 16, weight: .semibold))
                    Text("Back")
                        .font(.system(size: 16))
                }
                .foregroundColor(Color(red: 0.467, green: 0, blue: 1))
            }
            
            Spacer()
            
            Text("Favorite Drivers")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.black)
            
            Spacer()
            
            HStack(spacing: 8) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 16, weight: .semibold))
                Text("Back")
                    .font(.system(size: 16))
            }
            .opacity(0)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
        .background(Color.white)
        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
    }
    
    // MARK: - Empty State
    private var emptyStateView: some View {
        VStack(spacing: 20) {
            Image(systemName: "star.slash")
                .font(.system(size: 60))
                .foregroundColor(.gray)
            
            VStack(spacing: 8) {
                Text("No Favorite Drivers")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.black)
                
                Text("Add drivers you love to your favorites for easier access")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
            }
        }
        .padding(.top, 100)
    }
}

// MARK: - Driver Card Component
struct DriverCard: View {
    let driver: FavoriteDriver
    let onDelete: () -> Void
    
    var body: some View {
        HStack(spacing: 16) {
            // Driver Avatar
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [Color(red: 0.467, green: 0, blue: 1).opacity(0.2), Color(red: 0.6, green: 0.2, blue: 1).opacity(0.2)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 60, height: 60)
                
                Image(systemName: "person.fill")
                    .font(.system(size: 28))
                    .foregroundColor(Color(red: 0.467, green: 0, blue: 1))
            }
            
            // Driver Info
            VStack(alignment: .leading, spacing: 6) {
                Text(driver.name)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.black)
                
                HStack(spacing: 8) {
                    Image(systemName: "star.fill")
                        .font(.system(size: 12))
                        .foregroundColor(.orange)
                    
                    Text(String(format: "%.1f", driver.rating))
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.black)
                    
                    Text("•")
                        .foregroundColor(.gray)
                    
                    Text("\(driver.trips) trips")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                }
            }
            
            Spacer()
            
            // Delete Button
            Button(action: onDelete) {
                VStack(spacing: 4) {
                    Image(systemName: "trash.fill")
                        .font(.system(size: 16))
                        .foregroundColor(.red)
                    
                    Text("Remove")
                        .font(.system(size: 11, weight: .medium))
                        .foregroundColor(.red)
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.red.opacity(0.1))
                )
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 4)
        )
    }
}

#Preview {
    FavoriteDriversPassenger()
}
