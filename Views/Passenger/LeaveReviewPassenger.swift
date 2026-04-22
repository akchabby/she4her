import SwiftUI

struct LeaveReviewPassenger: View {
    @Environment(\.dismiss) private var dismiss
    @State private var rating: Int = 0
    @State private var reviewText: String = ""
    @State private var showSuccessAlert = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 32) {
                    // Logo
                    Image("She4HerLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 100)
                        .padding(.top, 20)
                    
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
                    
                    // Star Rating
                    VStack(spacing: 16) {
                        Text("How was your ride?")
                            .font(.system(size: 16, weight: .semibold))
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
                    .padding(24)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color(red: 0.98, green: 0.98, blue: 0.98))
                    )
                    
                    // Review Text Area
                    VStack(alignment: .leading, spacing: 16) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Write about your experience (Optional)")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.gray)
                            
                            ZStack(alignment: .topLeading) {
                                if reviewText.isEmpty {
                                    Text("Share details about your ride...")
                                        .font(.system(size: 15))
                                        .foregroundColor(.gray.opacity(0.6))
                                        .padding(.horizontal, 16)
                                        .padding(.vertical, 20)
                                }
                                
                                TextEditor(text: $reviewText)
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
                                    .stroke(reviewText.isEmpty ? Color.clear : Color(red: 0.467, green: 0, blue: 1).opacity(0.3), lineWidth: 1)
                            )
                        }
                    }
                    .padding(.horizontal, 20)
                    
                    // Action Buttons
                    VStack(spacing: 12) {
                        Button(action: {
                            submitReview()
                        }) {
                            Text("Submit Review")
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
                        
                        Button(action: {
                            dismiss()
                        }) {
                            Text("Skip")
                                .font(.system(size: 15, weight: .medium))
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.horizontal, 20)
                }
                .padding(.bottom, 40)
            }
            .background(Color.white)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 28))
                            .foregroundColor(.gray)
                    }
                }
            }
        }
        .alert("Thank You!", isPresented: $showSuccessAlert) {
            Button("Done", role: .cancel) {
                dismiss()
            }
        } message: {
            Text("Your review helps us improve our service.")
        }
    }
    
    private func submitReview() {
        print("Rating: \(rating)")
        print("Review: \(reviewText)")
        showSuccessAlert = true
    }
}

#Preview {
    LeaveReviewPassenger()
}
