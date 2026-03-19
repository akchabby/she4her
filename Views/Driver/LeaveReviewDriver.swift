import SwiftUI

struct LeavingAReviewDriver: View {
    @State private var rating: Int = 0
    @State private var reviewText: String = ""

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    // Logo
                    Image("She4HerLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 120)
                        .padding(.top, 24)

                    // Title & Subtitle
                    VStack(spacing: 8) {
                        Text("Share Your Thoughts!")
                            .font(.system(size: 22, weight: .semibold))
                            .foregroundColor(.primary)
                            .multilineTextAlignment(.center)
                        Text("Help us make She4Her even better!")
                            .font(.system(size: 16))
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.horizontal, 20)

                    // Star Rating
                    HStack(spacing: 16) {
                        ForEach(1...5, id: \.self) { index in
                            Image(systemName: index <= rating ? "star.fill" : "star")
                                .font(.system(size: 32))
                                .foregroundColor(.brandPurple)
                                .onTapGesture { rating = index }
                        }
                    }

                    // Review Text Area
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Write about your experience")
                            .font(.system(size: 14))
                            .foregroundColor(.secondary)

                        ZStack(alignment: .topLeading) {
                            if reviewText.isEmpty {
                                Text("Share details about your ride...")
                                    .font(.system(size: 16))
                                    .foregroundColor(.secondary)
                                    .padding(12)
                            }

                            TextEditor(text: $reviewText)
                                .font(.system(size: 16))
                                .frame(height: 150)
                                .padding(8)
                                .scrollContentBackground(.hidden)
                                .background(Color(UIColor.secondarySystemBackground))
                                .cornerRadius(12)
                        }
                    }
                    .padding(.horizontal, 20)

                    // Submit & Skip
                    VStack(spacing: 12) {
                        Button(action: { /* submit */ }) {
                            Text("Submit Review")
                                .font(.system(size: 17, weight: .semibold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 14)
                                .background(Color.brandPurple)
                                .cornerRadius(12)
                                .opacity(rating > 0 ? 1 : 0.5)
                        }
                        .disabled(rating == 0)

                        Button("Skip") { /* dismiss or navigate back */ }
                            .font(.system(size: 16))
                            .foregroundColor(.secondary)
                    }
                    .padding(.horizontal, 20)

                    Spacer(minLength: 0)
                }
                .padding(.top, 120)
                .padding(.bottom, 24)
            }
            .background(Color(UIColor.systemGroupedBackground))
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    LeavingAReviewDriver()
}
