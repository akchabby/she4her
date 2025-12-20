import SwiftUI

struct PickUpNotesPassenger: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Top bar
                HStack {
                    Spacer()
                    Text("$43.23")
                        .font(.system(size: 24, weight: .medium))
                        .foregroundColor(.black)
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.top, 32)
                .padding(.bottom, 8)
                
                // Search
                HStack(spacing: 8) {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.black.opacity(0.6))
                    TextField("Where to go?", text: .constant(""))
                        .font(.system(size: 16, weight: .medium))
                }
                .padding(.horizontal, 12)
                .frame(height: 44)
                .background(Color(white: 0.96))
                .cornerRadius(8)
                .padding(.horizontal, 20)
                .padding(.bottom, 8)
                
                // Content scroll
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 16) {
                        // Map responsive height
                        Image("map")
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: .infinity)
                            .frame(height: 240)
                            .clipped()
                            .cornerRadius(12)
                            .padding(.horizontal, 20)
                        
                        // Bottom sheet style container
                        VStack(alignment: .leading, spacing: 12) {
                            HStack {
                                Text("Pick Up Notes")
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundColor(.black)
                                Spacer()
                                Image(systemName: "xmark")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(Color(red: 0.47, green: 0, blue: 1))
                            }
                            
                            Text("Share important notes with your driver!")
                                .font(.system(size: 13))
                                .foregroundColor(.black.opacity(0.6))
                            
                            HStack(alignment: .center, spacing: 8) {
                                Image(systemName: "shield")
                                    .foregroundColor(Color(red: 0.47, green: 0, blue: 1))
                                Text("Driver may record audio for added safety.")
                                    .font(.system(size: 12))
                                    .foregroundColor(.black.opacity(0.8))
                                Spacer()
                            }
                            .padding(12)
                            .background(Color(white: 0.97))
                            .cornerRadius(12)
                            
                            // Notes input area
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Notes")
                                    .font(.system(size: 14, weight: .semibold))
                                TextEditor(text: .constant(""))
                                    .frame(height: 120)
                                    .padding(8)
                                    .background(Color(white: 0.96))
                                    .cornerRadius(8)
                            }
                            
                            // Actions
                            HStack(spacing: 12) {
                                Button(action: {
                                    dismiss()
                                }) {
                                    Text("Cancel")
                                        .font(.system(size: 14, weight: .semibold))
                                        .foregroundColor(.white)
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 44)
                                        .background(Color(red: 0.47, green: 0, blue: 1))
                                        .cornerRadius(8)
                                }
                                
                                Button(action: {
                                    dismiss()
                                }) {
                                    Text("Submit")
                                        .font(.system(size: 14, weight: .semibold))
                                        .foregroundColor(.white)
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 44)
                                        .background(Color(red: 0.47, green: 0, blue: 1))
                                        .cornerRadius(8)
                                }
                            }
                        }
                        .padding(16)
                        .background(Color.white)
                        .cornerRadius(20)
                        .shadow(color: Color.black.opacity(0.06), radius: 10, x: 0, y: 4)
                        .padding(.horizontal, 20)
                        .padding(.bottom, 20)
                    }
                }
            }
        }
    }
}

#Preview {
    PickUpNotesPassenger()
}
