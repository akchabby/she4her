import SwiftUI

struct HomeForPickupDriver: View {
    var body: some View {
        VStack(spacing: 0) {
            // Header bar (match HomePageDriver sizes)
            HStack {
                Image(systemName: "bell")
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundColor(.black)
                Spacer()
                Text("$205.12")
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundColor(.black)
                Spacer()
                Image(systemName: "line.3.horizontal")
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundColor(Color.purple)
            }
            .padding(.horizontal, 20)
            .frame(height: 56)
            .background(Color.white)
            .padding(.top, -8)
            
            // Map area
            ZStack {
                Image("map")
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity)
                    .frame(height: 400)
                    .clipped()
                
                // Purple radius circle
                Circle()
                    .stroke(Color.purple, lineWidth: 3)
                    .frame(width: 300, height: 300)
                
                // Route markers (pickup and dropoff icons)
                HStack(spacing: 40) {
                    VStack(spacing: 6) {
                        Image(systemName: "mappin.circle")
                            .foregroundColor(.purple)
                        Rectangle()
                            .fill(Color.purple)
                            .frame(width: 24, height: 4)
                            .cornerRadius(2)
                    }
                    Image(systemName: "bus.fill")
                        .foregroundColor(.white)
                        .padding(8)
                        .background(Circle().fill(Color.purple))
                }
                .offset(y: -10)
                
                // Center dot inside circle
                Circle()
                    .fill(Color.purple)
                    .frame(width: 10, height: 10)
                    .offset(x: -20, y: 40)
            }
            .background(Color.white)
            
            // Bottom card
            VStack(spacing: 16) {
                // Ride status + online indicator row
                HStack {
                    // Status toggle (visual only)
                    HStack(spacing: 10) {
                        Text("Ride In Progress")
                            .foregroundColor(.red)
                            .font(.system(size: 12, weight: .bold))
                        ZStack {
                            Capsule()
                                .stroke(Color.purple, lineWidth: 2)
                                .frame(width: 56, height: 28)
                            Circle()
                                .fill(Color.purple)
                                .frame(width: 20, height: 20)
                                .offset(x: -10)
                        }
                        Text("Ride Complete")
                            .foregroundColor(.black)
                            .font(.system(size: 12))
                    }
                    Spacer()
                    Text("Online")
                        .foregroundColor(.green)
                        .font(.system(size: 14, weight: .semibold))
                }
                
                // Address and ETA
                HStack(alignment: .top) {
                    Text("345 Iron Rock Jut Ave")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.black)
                    Spacer()
                    Text("10 min")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.black)
                }
                
                // Driver info card
                VStack(spacing: 12) {
                    HStack(alignment: .center) {
                        Circle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 40, height: 40)
                            .overlay(Image(systemName: "person.fill").foregroundColor(.white))
                        
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Jessie Stone")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(.black)
                            HStack(spacing: 6) {
                                Text("4.9")
                                Image(systemName: "star.fill")
                                    .font(.system(size: 10))
                                Text("·")
                                Text("12 trips")
                            }
                            .font(.system(size: 12))
                            .foregroundColor(.black)
                        }
                        Spacer()
                        // Safety button
                        HStack(spacing: 6) {
                            Image(systemName: "exclamationmark.triangle")
                                .foregroundColor(.red)
                            Text("Safety")
                                .font(.system(size: 12, weight: .semibold))
                        }
                    }
                    
                    HStack(spacing: 12) {
                        // Notes textfield placeholder
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white)
                            .frame(height: 36)
                            .shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 1)
                            .overlay(
                                HStack { Text("Any Pick-up notes?")
                                        .foregroundColor(Color.gray)
                                        .font(.system(size: 13))
                                        .padding(.leading, 10)
                                    Spacer() }
                            )
                        
                        // Cancel Ride button (match HomePageDriver purple button style)
                        Button(action: {}) {
                            Text("Cancel Ride")
                                .font(.system(size: 13, weight: .semibold))
                                .foregroundColor(.white)
                                .padding(.vertical, 8)
                                .padding(.horizontal, 14)
                                .background(Color.purple)
                                .cornerRadius(8)
                                .shadow(color: Color.black.opacity(0.25), radius: 3, x: 0, y: 2)
                        }
                    }
                }
                .padding(12)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.white)
                        .shadow(color: Color.black.opacity(0.1), radius: 6, x: 0, y: 2)
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
    HomeForPickupDriver()
}
