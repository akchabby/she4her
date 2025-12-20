import SwiftUI

struct HomeDestinationDriver: View {
    var body: some View {
        VStack(spacing: 0) {
            // Header bar
            HStack {
                Image(systemName: "bell")
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundColor(.black)
                Spacer()
                Text("$221.12")
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundColor(.black)
                Spacer()
                Image(systemName: "line.3.horizontal")
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundColor(Color.purple)
            }
            .padding(.horizontal, 20)
            .frame(height: 72)
            .background(Color.white)
            
            // Map area
            ZStack {
                Image("map")
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity)
                    .frame(height: 320)
                    .clipped()
                
                // Purple radius circle
                Circle()
                    .stroke(Color.purple, lineWidth: 3)
                    .frame(width: 320, height: 320)
                
                // Center dot
                Circle()
                    .fill(Color.purple)
                    .frame(width: 8, height: 8)
                
                // Bus marker on right
                Image(systemName: "bus.fill")
                    .foregroundColor(.white)
                    .padding(8)
                    .background(Circle().fill(Color.purple))
                    .offset(x: 120, y: 80)
            }
            .background(Color.white)
            
            // Bottom card
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    // Status controls
                    HStack(spacing: 10) {
                        Text("Ride In Progress")
                            .foregroundColor(.black)
                            .font(.system(size: 12))
                        ZStack {
                            Capsule()
                                .stroke(Color.purple, lineWidth: 2)
                                .frame(width: 56, height: 28)
                            Circle()
                                .fill(Color.purple)
                                .frame(width: 20, height: 20)
                                .offset(x: 10)
                        }
                        Text("Ride Complete")
                            .foregroundColor(.green)
                            .font(.system(size: 12, weight: .semibold))
                    }
                    Spacer()
                    Text("Online")
                        .foregroundColor(.green)
                        .font(.system(size: 14, weight: .semibold))
                }
                
                HStack(alignment: .top) {
                    Text("234 Main Street")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.black)
                    Spacer()
                    Text("Arrived!")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.black)
                }
                
                // Request card
                VStack(alignment: .leading, spacing: 8) {
                    HStack(alignment: .top) {
                        Text("$23")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.black)
                        Spacer()
                        Button(action: {}) {
                            Image(systemName: "xmark")
                                .foregroundColor(.black)
                        }
                    }
                    Text("12 minute drive")
                        .font(.system(size: 13))
                        .foregroundColor(.gray)
                    Text("6 minutes away")
                        .font(.system(size: 13))
                        .foregroundColor(.gray)
                    HStack {
                        Spacer()
                        Button("Decline") {}
                            .foregroundColor(.black)
                            .font(.system(size: 13, weight: .medium))
                        Button(action: {}) {
                            Text("Accept")
                                .font(.system(size: 13, weight: .semibold))
                                .foregroundColor(.white)
                                .padding(.vertical, 8)
                                .padding(.horizontal, 16)
                                .background(Color.purple)
                                .cornerRadius(8)
                                .shadow(color: Color.black.opacity(0.25), radius: 3, x: 0, y: 2)
                        }
                    }
                }
                .padding(12)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white)
                        .shadow(color: Color.black.opacity(0.15), radius: 6, x: 0, y: 2)
                )
            }
            .padding(.horizontal, 16)
            .padding(.top, 12)
            .padding(.bottom, 16)
            .background(
                RoundedRectangle(cornerRadius: 24)
                    .fill(Color.white)
                    .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: -2)
            )
        }
        .background(Color(.systemGroupedBackground))
    }
}

#Preview {
    HomeDestinationDriver()
}
