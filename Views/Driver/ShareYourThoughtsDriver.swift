import SwiftUI

struct ShareYourThoughtsDriver: View {
    @State private var showRateDriver = false
    @State private var showBlockAlert = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 32) {
                Spacer()
                
                // Logo/Icon
                Image("She4HerLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 140, height: 140)
                
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
                    ActionButton(
                        icon: "star.fill",
                        title: "Rate Passenger",
                        subtitle: "Share your experience",
                        action: {
                            showRateDriver = true
                        }
                    )
                    
                    ActionButton(
                        icon: "xmark.circle.fill",
                        title: "Block Passenger",
                        subtitle: "Won't be matched again",
                        iconColor: .red,
                        action: {
                            showBlockAlert = true
                        }
                    )
                }
                .padding(.horizontal, 32)
                
                Spacer()
                
                // Skip Button
                Button(action: {
                    dismiss()
                }) {
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
            RatePassengerView()
        }
        .alert("Block Passenger", isPresented: $showBlockAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Block", role: .destructive) {
                // Handle blocking
                dismiss()
            }
        } message: {
            Text("Are you sure you want to block this passenger? You won't be matched with them again.")
        }
    }
}

// MARK: - Action Button Component
struct ActionButton: View {
    let icon: String
    let title: String
    let subtitle: String
    var iconColor: Color = Color(red: 0.467, green: 0, blue: 1)
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
                    Text(title)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.black)
                    
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

// MARK: - Rate Passenger View
struct RatePassengerView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var rating: Int = 0
    @State private var review: String = ""
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 32) {
                    VStack(spacing: 16) {
                        Text("Rate Your Passenger")
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
                        
                        TextEditor(text: $review)
                            .font(.system(size: 15))
                            .foregroundColor(.black)
                            .frame(height: 150)
                            .padding(12)
                            .background(Color(red: 0.96, green: 0.96, blue: 0.96))
                            .cornerRadius(12)
                            .scrollContentBackground(.hidden)
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
            .navigationTitle("Rate Passenger")
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

#Preview {
    ShareYourThoughtsDriver()
}
