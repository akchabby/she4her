import SwiftUI

struct ShareYourThoughtsPassenger: View {
    @State private var showRateDriver = false
    @State private var showFavoriteInfo = false
    @State private var showBlockInfo = false
    @State private var showBlockAlert = false
    @State private var showAddFavorite = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 32) {
                Spacer()
                
                // She4Her Logo
                Image("She4HerLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 120)
                
                // Title Section
                VStack(spacing: 12) {
                    Text("Share Your Thoughts!")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.black)
                    
                    Text("Help us make She4Her even better!")
                        .font(.system(size: 15))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                }
                
                Spacer()
                
                // Action Buttons
                VStack(spacing: 16) {
                    PassengerActionButton(
                        icon: "star.fill",
                        title: "Rate Driver",
                        subtitle: "Share your experience",
                        action: {
                            showRateDriver = true
                        }
                    )
                    
                    PassengerActionButton(
                        icon: "heart.fill",
                        title: "Add Driver to Favorites",
                        subtitle: "Quick access to preferred drivers",
                        showInfo: true,
                        onInfoTap: {
                            showFavoriteInfo = true
                        },
                        action: {
                            showAddFavorite = true
                        }
                    )
                    
                    PassengerActionButton(
                        icon: "xmark.circle.fill",
                        title: "Block Driver",
                        subtitle: "Won't be matched again",
                        iconColor: .red,
                        showInfo: true,
                        onInfoTap: {
                            showBlockInfo = true
                        },
                        action: {
                            showBlockAlert = true
                        }
                    )
                }
                .padding(.horizontal, 32)
                
                Spacer()
                
                // Skip Button
                NavigationLink(destination: LeaveReviewPassenger()) {
                    Text("Skip")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                        )
                }
                .padding(.horizontal, 32)
                .padding(.bottom, 40)
            }
            .background(Color(red: 0.98, green: 0.98, blue: 0.98))
        }
        .sheet(isPresented: $showRateDriver) {
            RateDriverView()
        }
        .sheet(isPresented: $showAddFavorite) {
            AddToFavoritesView()
        }
        .alert("Add to Favorites", isPresented: $showFavoriteInfo) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Favorite drivers will appear at the top of your list when booking rides, making it easier to ride with drivers you trust.")
        }
        .alert("Block Driver", isPresented: $showBlockInfo) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Blocking a driver means you won't be matched with them in the future. This action can be undone in your settings.")
        }
        .alert("Block Driver", isPresented: $showBlockAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Block", role: .destructive) {
                // Handle blocking
            }
        } message: {
            Text("Are you sure you want to block this driver? You won't be matched with them again.")
        }
    }
}

// MARK: - Passenger Action Button Component
struct PassengerActionButton: View {
    let icon: String
    let title: String
    let subtitle: String
    var iconColor: Color = Color(red: 0.467, green: 0, blue: 1)
    var showInfo: Bool = false
    var onInfoTap: (() -> Void)? = nil
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                ZStack {
                    Circle()
                        .fill(iconColor.opacity(0.1))
                        .frame(width: 60, height: 60)
                    
                    Image(systemName: icon)
                        .font(.system(size: 28))
                        .foregroundColor(iconColor)
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    HStack(spacing: 8) {
                        Text(title)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.black)
                        
                        if showInfo {
                            Button(action: {
                                onInfoTap?()
                            }) {
                                Text("?")
                                    .font(.system(size: 12, weight: .bold))
                                    .foregroundColor(Color(red: 0.467, green: 0, blue: 1))
                                    .frame(width: 20, height: 20)
                                    .background(Color.white)
                                    .clipShape(Circle())
                                    .overlay(
                                        Circle()
                                            .stroke(Color(red: 0.467, green: 0, blue: 1), lineWidth: 1.5)
                                    )
                            }
                        }
                    }
                    
                    Text(subtitle)
                        .font(.system(size: 13))
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.gray)
            }
            .padding(20)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.white)
                    .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 4)
            )
        }
    }
}

// MARK: - Rate Driver View
struct RateDriverView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var rating: Int = 0
    @State private var review: String = ""
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 32) {
                    VStack(spacing: 16) {
                        Text("Rate Your Driver")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.black)
                        
                        HStack(spacing: 16) {
                            ForEach(1...5, id: \.self) { index in
                                Button(action: {
                                    withAnimation(.spring(response: 0.3)) {
                                        rating = index
                                    }
                                }) {
                                    Image(systemName: index <= rating ? "star.fill" : "star")
                                        .font(.system(size: 36))
                                        .foregroundColor(index <= rating ? .orange : .gray.opacity(0.3))
                                }
                            }
                        }
                    }
                    .padding(.top, 20)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Comments (Optional)")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.gray)
                        
                        ZStack(alignment: .topLeading) {
                            if review.isEmpty {
                                Text("Share details about your ride...")
                                    .font(.system(size: 15))
                                    .foregroundColor(.gray.opacity(0.6))
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 20)
                            }
                            
                            TextEditor(text: $review)
                                .font(.system(size: 15))
                                .foregroundColor(.black)
                                .frame(height: 150)
                                .padding(12)
                                .scrollContentBackground(.hidden)
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color(red: 0.96, green: 0.96, blue: 0.96))
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(review.isEmpty ? Color.clear : Color(red: 0.467, green: 0, blue: 1).opacity(0.3), lineWidth: 1)
                        )
                    }
                    .padding(.horizontal, 20)
                    
                    Button(action: {
                        dismiss()
                    }) {
                        Text("Submit Rating")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(rating > 0 ? Color(red: 0.467, green: 0, blue: 1) : Color.gray.opacity(0.5))
                                    .shadow(color: rating > 0 ? Color.black.opacity(0.25) : Color.clear, radius: 4, x: 0, y: 4)
                            )
                    }
                    .disabled(rating == 0)
                    .padding(.horizontal, 20)
                }
                .padding(.bottom, 40)
            }
            .background(Color.white)
            .navigationTitle("Rate Driver")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundColor(Color(red: 0.467, green: 0, blue: 1))
                }
            }
        }
    }
}

// MARK: - Add to Favorites View
struct AddToFavoritesView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var showSuccess = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 32) {
                Spacer()
                
                ZStack {
                    Circle()
                        .fill(Color(red: 0.467, green: 0, blue: 1).opacity(0.1))
                        .frame(width: 120, height: 120)
                    
                    Image(systemName: "heart.fill")
                        .font(.system(size: 60))
                        .foregroundColor(Color(red: 0.467, green: 0, blue: 1))
                }
                
                VStack(spacing: 12) {
                    Text("Add to Favorites")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.black)
                    
                    Text("This driver will be prioritized in your ride matches")
                        .font(.system(size: 15))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)
                }
                
                Spacer()
                
                VStack(spacing: 12) {
                    Button(action: {
                        showSuccess = true
                    }) {
                        Text("Add to Favorites")
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
                    
                    Button(action: {
                        dismiss()
                    }) {
                        Text("Cancel")
                            .font(.system(size: 15, weight: .medium))
                            .foregroundColor(.gray)
                    }
                }
                .padding(.horizontal, 32)
                .padding(.bottom, 40)
            }
            .background(Color.white)
            .navigationTitle("Favorite Driver")
            .navigationBarTitleDisplayMode(.inline)
        }
        .alert("Added to Favorites", isPresented: $showSuccess) {
            Button("OK", role: .cancel) {
                dismiss()
            }
        } message: {
            Text("Driver has been added to your favorites!")
        }
    }
}

#Preview {
    ShareYourThoughtsPassenger()
}
