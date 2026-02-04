import SwiftUI
import MapKit

struct SafetyPagePassenger: View {
    @State private var cameraPosition: MapCameraPosition = .automatic
    @State private var passengerCoordinate = CLLocationCoordinate2D(latitude: 37.3349, longitude: -122.0090)
    @State private var driverCoordinate = CLLocationCoordinate2D(latitude: 37.3317, longitude: -122.0301)
    @State private var route: MKRoute?
    @State private var showEmergencyAlert = false

    var body: some View {
        ZStack {
            // Map Background
            Map(position: $cameraPosition) {
                Marker("Passenger", coordinate: passengerCoordinate)
                    .tint(Color(red: 0.467, green: 0, blue: 1))
                Marker("Driver", coordinate: driverCoordinate)
                    .tint(.blue)
                if let route {
                    MapPolyline(route.polyline)
                        .stroke(Color(red: 0.467, green: 0, blue: 1), lineWidth: 4)
                }
            }
            .mapStyle(.standard)
            .edgesIgnoringSafeArea(.all)
            
            // Slight overlay
            Color.black.opacity(0.1)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                topBar
                Spacer()
                safetySheet
            }
        }
        .onAppear {
            calculateRoute()
        }
        .alert("Emergency Call", isPresented: $showEmergencyAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Call 911", role: .destructive) {
                // Handle emergency call
            }
        } message: {
            Text("Are you sure you want to call emergency services?")
        }
    }
    
    // MARK: - Top Bar
    private var topBar: some View {
        HStack {
            NavigationLink(destination: NotificationPassenger()) {
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
            
            VStack(spacing: 2) {
                Text("$43.23")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.white)
                Text("Balance")
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
            
            Button(action: {}) {
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
        .padding(.top, 8)
        .offset(y: 3)
    }
    
    // MARK: - Safety Sheet
    private var safetySheet: some View {
        VStack(spacing: 0) {
            RoundedRectangle(cornerRadius: 3)
                .fill(Color.gray.opacity(0.3))
                .frame(width: 40, height: 5)
                .padding(.top, 12)
            
            VStack(spacing: 20) {
                Text("Safety Center")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack(spacing: 12) {
                    SafetyActionButton(
                        icon: "phone.fill",
                        title: "911 Speed Dial",
                        subtitle: "Call emergency services",
                        iconColor: .red,
                        action: {
                            showEmergencyAlert = true
                        }
                    )
                    
                    NavigationLink(destination: SafetyPageRecording()) {
                        SafetyActionButtonView(
                            icon: "record.circle",
                            title: "Record",
                            subtitle: "Start audio recording",
                            iconColor: Color(red: 0.467, green: 0, blue: 1)
                        )
                    }
                    
                    SafetyActionButton(
                        icon: "location.fill",
                        title: "Share Location",
                        subtitle: "Share with emergency contacts",
                        iconColor: Color(red: 0.467, green: 0, blue: 1),
                        action: {
                            // Handle location sharing
                        }
                    )
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 8)
            .padding(.bottom, 32)
        }
        .background(
            RoundedRectangle(cornerRadius: 24)
                .fill(Color.white)
                .shadow(color: .black.opacity(0.1), radius: 20, x: 0, y: -4)
        )
        .offset(y: 34)
        .edgesIgnoringSafeArea(.bottom)
    }
    
    // MARK: - Helper
    private func calculateRoute() {
        let center = CLLocationCoordinate2D(
            latitude: (passengerCoordinate.latitude + driverCoordinate.latitude) / 2,
            longitude: (passengerCoordinate.longitude + driverCoordinate.longitude) / 2
        )
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        cameraPosition = .region(region)

        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: driverCoordinate))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: passengerCoordinate))
        request.transportType = .automobile

        let directions = MKDirections(request: request)
        directions.calculate { response, error in
            if let route = response?.routes.first {
                self.route = route
            }
        }
    }
}

// MARK: - Safety Action Button Component
struct SafetyActionButton: View {
    let icon: String
    let title: String
    let subtitle: String
    let iconColor: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            SafetyActionButtonView(icon: icon, title: title, subtitle: subtitle, iconColor: iconColor)
        }
    }
}

struct SafetyActionButtonView: View {
    let icon: String
    let title: String
    let subtitle: String
    var iconColor: Color = Color(red: 0.467, green: 0, blue: 1)
    
    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(iconColor.opacity(0.1))
                    .frame(width: 60, height: 60)
                
                Image(systemName: icon)
                    .font(.system(size: 26))
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
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(red: 0.98, green: 0.98, blue: 0.98))
        )
    }
}

#Preview {
    SafetyPagePassenger()
}

