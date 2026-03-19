import SwiftUI

struct FavoriteDriversEditingPassenger: View {
    @State private var favoriteDrivers: [FavoriteDriver] = [
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
                
                if favoriteDrivers.isEmpty {
                    emptyStateView
                } else {
                    ScrollView {
                        VStack(spacing: 16) {
                            ForEach(favoriteDrivers) { driver in
                                EditableDriverCard(
                                    driver: driver,
                                    onDelete: {
                                        driverToDelete = driver
                                        showDeleteAlert = true
                                    }
                                )
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 20)
                        .padding(.bottom, 40)
                    }
                }
                
                if !favoriteDrivers.isEmpty {
                    doneButton
                }
            }
            .background(Color(red: 0.98, green: 0.98, blue: 0.98))
            .navigationBarBackButtonHidden(true)
        }
        .alert("Remove Favorite", isPresented: $showDeleteAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Remove", role: .destructive) {
                if let driver = driverToDelete {
                    favoriteDrivers.removeAll { $0.id == driver.id }
                }
            }
        } message: {
            if let driver = driverToDelete {
                Text("Remove \(driver.name) from your favorites?")
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
            
            Text("Edit Favorites")
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
        VStack(spacing: 24) {
            Spacer()
            
            ZStack {
                Circle()
                    .fill(Color.gray.opacity(0.1))
                    .frame(width: 100, height: 100)
                
                Image(systemName: "star.slash")
                    .font(.system(size: 50))
                    .foregroundColor(.gray)
            }
            
            VStack(spacing: 8) {
                Text("No Favorite Drivers")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.black)
                
                Text("You haven't added any drivers to your favorites yet")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
            }
            
            Spacer()
        }
    }
    
    // MARK: - Done Button
    private var doneButton: some View {
        Button(action: {
            dismiss()
        }) {
            Text("Done")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(red: 0.467, green: 0, blue: 1))
                        .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 4)
                )
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 32)
    }
}

// MARK: - Editable Driver Card Component
struct EditableDriverCard: View {
    let driver: FavoriteDriver
    let onDelete: () -> Void
    @State private var showingDetail = false
    
    var body: some View {
        VStack(spacing: 0) {
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
                    
                    Text(String(driver.name.prefix(1)))
                        .font(.system(size: 24, weight: .bold))
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
                    Image(systemName: "trash.circle.fill")
                        .font(.system(size: 32))
                        .foregroundColor(.red)
                }
            }
            .padding(16)
        }
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 4)
        )
    }
}

#Preview {
    FavoriteDriversEditingPassenger()
}
