import SwiftUI
import MapKit

struct HomeBeforePickupDriverOnline: View {
    @StateObject private var locationManager = LocationManager()
    @State private var isOnline = true
    @State private var showRideRequest = false
    @State private var showMenuSheet = false
    @State private var mapPosition: MapCameraPosition = .userLocation(fallback: .automatic)
    @State private var currentRideIndex = 0
    
    // Multiple ride requests that cycle through when declined
    let rideRequests: [(price: Int, duration: Int, distance: Int)] = [
        (16, 20, 15),
        (18, 15, 10),
        (22, 25, 12),
        (14, 18, 8),
        (20, 22, 14)
    ]
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Map View
                Map(position: $mapPosition) {
                    // User location marker
                    if let location = locationManager.userLocation {
                        Annotation("Me", coordinate: location.coordinate) {
                            ZStack {
                                Circle()
                                    .fill(Color.white)
                                    .frame(width: 36, height: 36)
                                    .shadow(color: .black.opacity(0.3), radius: 4)
                                
                                Circle()
                                    .fill(Color(red: 0.467, green: 0, blue: 1))
                                    .frame(width: 24, height: 24)
                                
                                Image(systemName: "car.fill")
                                    .font(.system(size: 12, weight: .semibold))
                                    .foregroundColor(.white)
                            }
                        }
                    }
                }
                .mapControls {
                    MapUserLocationButton()
                    MapCompass()
                }
                .mapStyle(.standard)
                .edgesIgnoringSafeArea(.all)
                
                // Availability Radius Overlay
                if isOnline {
                    availabilityRadiusOverlay
                }
                
                // Top Status Bar
                VStack {
                    topStatusBar
                    Spacer()
                }
                
                // Bottom Sheet
                VStack {
                    Spacer()
                    bottomSheet
                }
            }
        }
        .sheet(isPresented: $showMenuSheet) {
            MenuDriver()
        }
        .onAppear {
            locationManager.requestAuthorization()
            // Simulate incoming ride request after 3 seconds when online
            if isOnline {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    showRideRequest = true
                }
            }
        }
        .onChange(of: locationManager.userLocation) { newLocation in
            if let location = newLocation {
                updateMapPosition(for: location)
            }
        }
    }
    
    // MARK: - Top Status Bar
    private var topStatusBar: some View {
        HStack {
            // Notification Button
            NavigationLink(destination: NotificationDriver()) {
                Image(systemName: "bell.fill")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(12)
                    .background(
                        Circle()
                            .fill(Color.black.opacity(0.6))
                            .shadow(color: .black.opacity(0.3), radius: 8, x: 0, y: 4)
                    )
            }
            
            Spacer()
            
            // Earnings Display
            VStack(spacing: 2) {
                Text("$205.12")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.white)
                Text("Today")
                    .font(.system(size: 11))
                    .foregroundColor(.white.opacity(0.8))
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.black.opacity(0.6))
                    .shadow(color: .black.opacity(0.3), radius: 8, x: 0, y: 4)
            )
            
            Spacer()
            
            // Menu Button
            Button(action: {
                showMenuSheet = true
            }) {
                Image(systemName: "line.3.horizontal")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(12)
                    .background(
                        Circle()
                            .fill(Color.black.opacity(0.6))
                            .shadow(color: .black.opacity(0.3), radius: 8, x: 0, y: 4)
                    )
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 70)
        .ignoresSafeArea(.container, edges: .top)
    }
    
    // MARK: - Availability Radius Overlay
    private var availabilityRadiusOverlay: some View {
        ZStack {
            Circle()
                .stroke(Color(red: 0.467, green: 0, blue: 1).opacity(0.3), lineWidth: 2)
                .fill(Color(red: 0.467, green: 0, blue: 1).opacity(0.1))
                .frame(width: 300, height: 300)
            
            // Nearby ride indicators
            nearbyRideIndicator(minutes: 4, xOffset: 80, yOffset: -40)
            nearbyRideIndicator(minutes: 10, xOffset: -70, yOffset: 30)
            nearbyRideIndicator(minutes: 15, xOffset: 20, yOffset: 90)
        }
        .offset(y: -50)
    }
    
    private func nearbyRideIndicator(minutes: Int, xOffset: CGFloat, yOffset: CGFloat) -> some View {
        VStack(spacing: 4) {
            Image(systemName: "figure.wave")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.white)
                .padding(8)
                .background(
                    Circle()
                        .fill(Color(red: 0.467, green: 0, blue: 1))
                        .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2)
                )
            
            Text("\(minutes) min")
                .font(.system(size: 10, weight: .semibold))
                .foregroundColor(.white)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(
                    Capsule()
                        .fill(Color(red: 0.467, green: 0, blue: 1))
                        .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2)
                )
        }
        .offset(x: xOffset, y: yOffset)
    }
    
    // MARK: - Bottom Sheet
    private var bottomSheet: some View {
        VStack(spacing: 0) {
            // Drag Handle
            RoundedRectangle(cornerRadius: 3)
                .fill(Color.gray.opacity(0.3))
                .frame(width: 40, height: 5)
                .padding(.top, 12)
            
            ScrollView {
                if showRideRequest && isOnline {
                    rideRequestView
                } else {
                    waitingForRidesView
                }
            }
            .frame(maxHeight: 280)
        }
        .background(
            RoundedRectangle(cornerRadius: 24)
                .fill(Color.white)
                .shadow(color: .black.opacity(0.1), radius: 20, x: 0, y: -4)
        )
        .edgesIgnoringSafeArea(.bottom)
    }
    
    // MARK: - Waiting for Rides View
    private var waitingForRidesView: some View {
        VStack(spacing: 24) {
            // Online/Offline Toggle Section
            toggleSection
            
            // Status Message
            VStack(spacing: 12) {
                Image(systemName: isOnline ? "antenna.radiowaves.left.and.right" : "moon.zzz.fill")
                    .font(.system(size: 48))
                    .foregroundColor(isOnline ? Color(red: 0.467, green: 0, blue: 1) : .gray)
                
                Text(isOnline ? "Looking for rides nearby..." : "You're offline")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.black)
                
                Text(isOnline ? "We'll notify you when a ride request comes in" : "Go online to start receiving ride requests")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
            }
            .padding(.vertical, 20)
        }
        .padding(.top, 16)
        .padding(.bottom, 32)
    }
    
    // MARK: - Toggle Section
    private var toggleSection: some View {
        HStack(spacing: 16) {
            Text("Offline")
                .font(.system(size: 14, weight: isOnline ? .regular : .bold))
                .foregroundColor(isOnline ? .gray : .red)
            
            // Custom Toggle
            ZStack {
                Capsule()
                    .fill(isOnline ? Color.green.opacity(0.2) : Color.gray.opacity(0.2))
                    .frame(width: 56, height: 32)
                
                Circle()
                    .fill(isOnline ? Color.green : Color.gray)
                    .frame(width: 26, height: 26)
                    .offset(x: isOnline ? 13 : -13)
                    .animation(.spring(response: 0.3), value: isOnline)
            }
            .onTapGesture {
                withAnimation {
                    isOnline.toggle()
                    if isOnline {
                        // Simulate incoming ride request after going online
                        currentRideIndex = 0 // Reset to first ride
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            showRideRequest = true
                        }
                    } else {
                        showRideRequest = false
                    }
                }
            }
            
            Text("Online")
                .font(.system(size: 14, weight: isOnline ? .bold : .regular))
                .foregroundColor(isOnline ? .green : .gray)
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 14)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(red: 0.98, green: 0.98, blue: 0.98))
        )
    }
    
    // MARK: - Ride Request View
    private var rideRequestView: some View {
        VStack(spacing: 20) {
            // Request Header
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("New Ride Request")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.black)
                    
                    Text("Passenger nearby")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                // Countdown Timer
                ZStack {
                    Circle()
                        .stroke(Color.gray.opacity(0.2), lineWidth: 3)
                        .frame(width: 50, height: 50)
                    
                    Circle()
                        .trim(from: 0, to: 0.7)
                        .stroke(Color(red: 0.467, green: 0, blue: 1), lineWidth: 3)
                        .frame(width: 50, height: 50)
                        .rotationEffect(.degrees(-90))
                    
                    Text("30s")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(Color(red: 0.467, green: 0, blue: 1))
                }
            }
            .padding(.horizontal, 24)
            .padding(.top, 20)
            
            // Ride Details Card
            VStack(spacing: 16) {
                // Fare
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Estimated Fare")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                        Text("$\(rideRequests[currentRideIndex].price).00")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(Color(red: 0.467, green: 0, blue: 1))
                    }
                    
                    Spacer()
                }
                
                Divider()
                
                // Trip Details
                HStack(spacing: 20) {
                    DetailItem(icon: "car.fill", title: "Trip Duration", value: "\(rideRequests[currentRideIndex].duration) min")
                    DetailItem(icon: "location.fill", title: "Distance", value: "\(rideRequests[currentRideIndex].distance) min away")
                }
            }
            .padding(20)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(red: 0.98, green: 0.98, blue: 0.98))
            )
            .padding(.horizontal, 20)
            
            // Action Buttons
            HStack(spacing: 12) {
                Button(action: {
                    // Decline and show next ride request
                    withAnimation {
                        showRideRequest = false
                    }
                    
                    // Move to next ride in the array
                    currentRideIndex = (currentRideIndex + 1) % rideRequests.count
                    
                    // Show next ride request after 2 seconds
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        if isOnline {
                            withAnimation {
                                showRideRequest = true
                            }
                        }
                    }
                }) {
                    Text("Decline")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(Color(red: 0.467, green: 0, blue: 1))
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(red: 0.467, green: 0, blue: 1), lineWidth: 2)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.white)
                                )
                        )
                }
                
                NavigationLink(destination: HomeForPickupDriver()) {
                    Text("Accept")
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
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 32)
        }
    }
    
    // MARK: - Helper Methods
    private func updateMapPosition(for location: CLLocation) {
        let span = MKCoordinateSpan(latitudeDelta: 0.015, longitudeDelta: 0.015)
        let region = MKCoordinateRegion(center: location.coordinate, span: span)
        withAnimation {
            mapPosition = .region(region)
        }
    }
}

// MARK: - Detail Item Component
struct DetailItem: View {
    let icon: String
    let title: String
    let value: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 16))
                .foregroundColor(Color(red: 0.467, green: 0, blue: 1))
                .frame(width: 24)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.system(size: 11))
                    .foregroundColor(.gray)
                Text(value)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.black)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    HomeBeforePickupDriverOnline()
}
