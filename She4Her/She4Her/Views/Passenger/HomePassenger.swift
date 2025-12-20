import SwiftUI
import MapKit

struct HomePassenger: View {
    @State private var cameraPosition: MapCameraPosition = .userLocation(fallback: .automatic)
    @State private var showsUserLocation: Bool = true
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                // Background Map (live)
                Map(position: $cameraPosition, interactionModes: [.pan, .zoom, .rotate]) {
                }
                .mapStyle(.standard(elevation: .realistic))
                .ignoresSafeArea()
                .tint(.purple)

                VStack(spacing: 16) {
                    //
                    // Top Bar
                    VStack(spacing: 0) {
                        HStack {
                            Button(action: {}) {
                                Image(systemName: "bell")
                                    .foregroundColor(.black)
                                    .font(.system(size: 20, weight: .semibold))
                            }

                            Spacer()

                            Text("$43.23")
                                .font(.system(size: 24, weight: .medium))
                                .foregroundColor(.black)

                            Spacer()

                            NavigationLink(destination: MenuPassenger()) {
                                Image(systemName: "line.3.horizontal")
                                    .foregroundColor(Color(red: 0.467, green: 0, blue: 1))
                                    .font(.system(size: 22, weight: .bold))
                                    .frame(width: 32, height: 32)
                            }
                            .buttonStyle(.plain)
                        }
                        .padding(.horizontal)
                        .padding(.top, 8)
                        .padding(.bottom, 8)
                    }
                    .frame(maxWidth: .infinity, alignment: .top)
                    .background(Color.white)
                    .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)

                    // Search Bar
                    HStack(spacing: 8) {
                        TextField("Where to go?", text: .constant(""))
                            .padding(.horizontal)
                            .frame(height: 43)

                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.black.opacity(0.8))
                    }
                    .padding(.horizontal, 24)

                    Spacer()

                    // Bottom Card
                    VStack(spacing: 16) {
                        // Safety Notice
                        HStack(spacing: 8) {
                            Image(systemName: "shield")
                                .foregroundColor(Color(red: 0.467, green: 0, blue: 1))
                            Text("Driver may record audio for added safety.")
                                .font(.system(size: 11))
                                .foregroundColor(.primary)
                        }
                        .padding(.vertical, 8)
                        .padding(.horizontal, 12)
                        .background(
                            RoundedRectangle(cornerRadius: 22)
                                .fill(Color.white)
                                .shadow(color: .black.opacity(0.1), radius: 6, x: 0, y: 2)
                        )

                        // Schedule Ride Section
                        VStack(spacing: 12) {
                            Text("Know where to in advance?\nSchedule your ride to cut the wait!")
                                .multilineTextAlignment(.center)
                                .font(.system(size: 13, weight: .medium))
                                .foregroundColor(.primary)

                            Button(action: {}) {
                                Text("Schedule Ride")
                                    .foregroundColor(.white)
                                    .font(.system(size: 11, weight: .semibold))
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 38)
                                    .background(Color(red: 0.467, green: 0, blue: 1))
                                    .cornerRadius(5)
                                    .shadow(color: .black.opacity(0.15), radius: 4, x: 0, y: 2)
                            }
                        }
                    }
                    .padding(20)
                    .frame(maxWidth: 380)
                    .background(
                        RoundedRectangle(cornerRadius: 24)
                            .fill(Color.white)
                            .shadow(color: .black.opacity(0.15), radius: 10, x: 0, y: -2)
                    )
                    .padding(.horizontal)
                    .padding(.bottom)
                }

                // Location Pin and label (overlayed on map)
                VStack(spacing: 6) {
                    Circle()
                        .fill(Color(red: 0.467, green: 0, blue: 1))
                        .frame(width: 20, height: 20)
                    Text("Me")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.black)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .padding(.top, 80)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white)
        }
    }
}

#Preview {
    HomePassenger()
}

