import SwiftUI
import MapKit
import Combine

struct HomePageDriver: View {
    @StateObject private var locationManager = LocationManager()
    @State private var isOnline = true
    @State private var navigateToOffline = false
    @State private var showMenuSheet = false
    @State private var mapPosition: MapCameraPosition = .userLocation(fallback: .automatic)
    
    // Sample nearby ride requests
    @State private var nearbyRides: [RideRequest] = [
        RideRequest(id: "1", price: 16, duration: 20, distance: 15),
        RideRequest(id: "2", price: 18, duration: 15, distance: 10)
    ]
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Full-screen Map
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
                        
                        // 1km radius circle around driver
                        MapCircle(center: location.coordinate, radius: 1000)
                            .foregroundStyle(Color(red: 0.467, green: 0, blue: 1).opacity(0.1))
                            .stroke(Color(red: 0.467, green: 0, blue: 1), lineWidth: 2)
                    }
                    
                    // Sample passenger locations
                    ForEach(samplePassengerLocations) { passenger in
                        Annotation("", coordinate: passenger.coordinate) {
                            VStack(spacing: 4) {
                                Image(systemName: "figure.wave")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(.white)
                                    .frame(width: 34, height: 34)
                                    .background(
                                        Circle()
                                            .fill(Color(red: 0.467, green: 0, blue: 1))
                                            .shadow(color: .black.opacity(0.3), radius: 4, x: 0, y: 2)
                                    )
                                
                                Text(passenger.timeAway)
                                    .font(.system(size: 10, weight: .semibold))
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(
                                        Capsule()
                                            .fill(Color(red: 0.467, green: 0, blue: 1))
                                            .shadow(color: .black.opacity(0.2), radius: 2)
                                    )
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
                
                VStack(spacing: 0) {
                    // Hidden navigation link
                    NavigationLink(destination: HomeforPickupOfflineDriver(), isActive: $navigateToOffline) {
                        EmptyView()
                    }
                    
                    // Top Bar
                    topBar
                    
                    Spacer()
                    
                    // Bottom Sheet
                    bottomSheet
                }
            }
        }
        .sheet(isPresented: $showMenuSheet) {
            MenuDriver()
        }
        .onAppear {
            locationManager.requestAuthorization()
        }
        .onChange(of: locationManager.userLocation) { newLocation in
            if let location = newLocation {
                updateMapPosition(for: location)
            }
        }
        .onChange(of: isOnline) { newValue in
            if !newValue {
                navigateToOffline = true
            }
        }
    }
    
    // MARK: - Top Bar
    private var topBar: some View {
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
        .padding(.top, -30)
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
                VStack(spacing: 20) {
                    // Online/Offline Toggle
                    toggleSection
                    
                    // Nearby Passengers Header
                    HStack {
                        Text("Nearby Passengers")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.black)
                        
                        Spacer()
                        
                        // Online Badge
                        HStack(spacing: 6) {
                            Circle()
                                .fill(isOnline ? Color.green : Color.gray)
                                .frame(width: 8, height: 8)
                            Text(isOnline ? "Online" : "Offline")
                                .font(.system(size: 13, weight: .semibold))
                                .foregroundColor(isOnline ? .green : .gray)
                        }
                    }
                    
                    // Ride Request Cards
                    if nearbyRides.isEmpty {
                        emptyStateView
                    } else {
                        VStack(spacing: 12) {
                            ForEach(nearbyRides) { ride in
                                RideRequestCardEnhanced(ride: ride, onDismiss: {
                                    withAnimation {
                                        nearbyRides.removeAll { $0.id == ride.id }
                                    }
                                })
                            }
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 16)
                .padding(.bottom, 32)
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
    
    // MARK: - Empty State
    private var emptyStateView: some View {
        VStack(spacing: 16) {
            Image(systemName: "antenna.radiowaves.left.and.right")
                .font(.system(size: 40))
                .foregroundColor(Color(red: 0.467, green: 0, blue: 1))
            
            VStack(spacing: 6) {
                Text("Looking for rides...")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.black)
                
                Text("We'll notify you when a passenger nearby requests a ride")
                    .font(.system(size: 13))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
            }
        }
        .padding(.vertical, 32)
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

// MARK: - Enhanced Ride Request Card
struct RideRequestCardEnhanced: View {
    let ride: RideRequest
    let onDismiss: () -> Void
    @State private var showAcceptConfirmation = false
    
    var body: some View {
        VStack(spacing: 16) {
            // Header with price and dismiss
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("New Ride Request")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                    
                    Text("$\(ride.price).00")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(Color(red: 0.467, green: 0, blue: 1))
                }
                
                Spacer()
                
                Button(action: onDismiss) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 24))
                        .foregroundColor(.gray)
                }
            }
            
            Divider()
            
            // Ride details
            HStack(spacing: 20) {
                DetailItemIcon(icon: "car.fill", label: "Trip", value: "\(ride.duration) min")
                DetailItemIcon(icon: "location.fill", label: "Distance", value: "\(ride.distance) min away")
            }
            
            // Action Buttons
            HStack(spacing: 12) {
                Button(action: onDismiss) {
                    Text("Decline")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(Color(red: 0.467, green: 0, blue: 1))
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(red: 0.467, green: 0, blue: 1), lineWidth: 2)
                        )
                }
                
                Button(action: {
                    showAcceptConfirmation = true
                }) {
                    Text("Accept")
                        .font(.system(size: 15, weight: .semibold))
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
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 4)
        )
        .alert("Accept Ride?", isPresented: $showAcceptConfirmation) {
            Button("Cancel", role: .cancel) {}
            Button("Accept") {
                // Navigate to ride acceptance
            }
        } message: {
            Text("Accept this ride request for $\(ride.price)?")
        }
    }
}

// MARK: - Detail Item with Icon
struct DetailItemIcon: View {
    let icon: String
    let label: String
    let value: String
    
    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: icon)
                .font(.system(size: 16))
                .foregroundColor(Color(red: 0.467, green: 0, blue: 1))
                .frame(width: 24)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(label)
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

// MARK: - Models
struct RideRequest: Identifiable {
    let id: String
    let price: Int
    let duration: Int
    let distance: Int
}

struct PassengerLocation: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
    let timeAway: String
}

// MARK: - Sample Data
private let samplePassengerLocations: [PassengerLocation] = [
    PassengerLocation(coordinate: CLLocationCoordinate2D(latitude: 37.3360, longitude: -122.0095), timeAway: "10 min"),
    PassengerLocation(coordinate: CLLocationCoordinate2D(latitude: 37.3340, longitude: -122.0120), timeAway: "4 min"),
    PassengerLocation(coordinate: CLLocationCoordinate2D(latitude: 37.3320, longitude: -122.0080), timeAway: "15 min")
]

#Preview {
    HomePageDriver()
}
