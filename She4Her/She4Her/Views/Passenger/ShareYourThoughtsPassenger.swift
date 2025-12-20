import SwiftUI

struct ShareYourThoughtsPassenger: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                VStack(alignment: .center, spacing: 8) {
                    Image("She4HerLogo")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 175)
                        .clipped()
                        .padding(.top, 95)
                    
                    Text("Share Your Thoughts!")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.black)
                    
                    Text("Help us make She4Her even better!")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(.black)
                }
                .padding(.top, 95)
                
                VStack(spacing: 16) {
                    // Rate Driver
                    HStack {
                        HStack {
                            Image(systemName: "star")
                                .foregroundColor(Color(red: 0.467, green: 0, blue: 1))
                                .frame(width: 50, height: 48)
                                .background(Color.white)
                                .cornerRadius(25)
                                .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
                            Spacer(minLength: 0)
                        }
                        .frame(width: 70, alignment: .leading)
                        
                        Text("Rate Driver")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.black)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    // Add Driver to Favorite
                    HStack {
                        HStack {
                            Image(systemName: "plus")
                                .foregroundColor(Color(red: 0.467, green: 0, blue: 1))
                                .frame(width: 50, height: 48)
                                .background(Color.white)
                                .cornerRadius(25)
                                .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
                            Spacer(minLength: 0)
                        }
                        .frame(width: 70, alignment: .leading)
                        
                        HStack(spacing: 8) {
                            Text("Add Driver to Favorite")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.black)

                            NavigationLink(destination: ShareYourThoughtsQ1()) {
                                Text("?")
                                    .font(.system(size: 12, weight: .bold))
                                    .foregroundColor(Color(red: 0.467, green: 0, blue: 1))
                                    .frame(width: 18, height: 18)
                                    .background(Color.white)
                                    .clipShape(Circle())
                                    .overlay(
                                        Circle()
                                            .stroke(Color(red: 0.467, green: 0, blue: 1), lineWidth: 1)
                                    )
                                    .shadow(color: .black.opacity(0.1), radius: 1, x: 0, y: 1)
                                    .accessibilityLabel("What does Add Driver to Favorite mean?")
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    // Block Driver
                    HStack {
                        HStack {
                            Image(systemName: "person.fill")
                                .foregroundColor(Color(red: 0.467, green: 0, blue: 1))
                                .frame(width: 50, height: 48)
                                .background(Color.white)
                                .cornerRadius(25)
                                .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
                            Spacer(minLength: 0)
                        }
                        .frame(width: 70, alignment: .leading)
                        
                        HStack(spacing: 8) {
                            Text("Block Driver")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.black)

                            NavigationLink(destination: ShareYourThoughtsQ2()) {
                                Text("?")
                                    .font(.system(size: 12, weight: .bold))
                                    .foregroundColor(Color(red: 0.467, green: 0, blue: 1))
                                    .frame(width: 18, height: 18)
                                    .background(Color.white)
                                    .clipShape(Circle())
                                    .overlay(
                                        Circle()
                                            .stroke(Color(red: 0.467, green: 0, blue: 1), lineWidth: 1)
                                    )
                                    .shadow(color: .black.opacity(0.1), radius: 1, x: 0, y: 1)
                                    .accessibilityLabel("What does Block Driver mean?")
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.top, 40)
                .padding(.leading, 70)
                .frame(maxWidth: .infinity, alignment: .center)
                
                Spacer()
                
                NavigationLink(destination: LeaveReviewPassenger()) {
                    Text("Skip")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 43)
                        .background(Color(red: 0.467, green: 0, blue: 1))
                        .cornerRadius(10)
                        .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
                }
                .padding(.horizontal, 86)
                .padding(.bottom, 40)
            }
        }
    }
}
#Preview {
    ShareYourThoughtsPassenger()
}
