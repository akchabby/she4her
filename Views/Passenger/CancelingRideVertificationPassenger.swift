import SwiftUI
import MapKit

struct CancelingRidePassenger: View {
    @State private var cameraPosition: MapCameraPosition = .automatic
    @State private var passengerCoordinate = CLLocationCoordinate2D(latitude: 37.3349, longitude: -122.0090)
    @State private var driverCoordinate = CLLocationCoordinate2D(latitude: 37.3317, longitude: -122.0301)
    @State private var route: MKRoute?
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ZStack {
                // Live map background
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
                    // Top Bar
                    topBar
                    
                    Spacer()
                    
                    // Cancellation Warning Card
                    cancellationCard
                }
            }
            .navigationBarHidden(true)
        }
        .onAppear {
            calculateRoute()
        }
    }
    
    // MARK: - Top Bar
    private var topBar: some View {
        HStack {
            // Notification Button
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
            
            // Balance Display
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
            
            // Menu Button
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
        .offset(y: -4)
    }
    
    // MARK: - Cancellation Card
    private var cancellationCard: some View {
        VStack(spacing: 24) {
            // Warning Icon
            ZStack {
                Circle()
                    .fill(Color.red.opacity(0.1))
                    .frame(width: 100, height: 100)
                
                Image(systemName: "exclamationmark.triangle.fill")
                    .font(.system(size: 60))
                    .foregroundColor(.red)
            }
            
            // Warning Message
            VStack(spacing: 12) {
                Text("Cancel Your Ride?")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(.black)
                
                Text("Are you sure you want to cancel your ride?")
                    .font(.system(size: 15))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
            }
            
            // Action Buttons
            VStack(spacing: 12) {
                // Cancel Ride Button (destructive)
                NavigationLink(destination: CancelingRideCompletePassenger()) {
                    Text("Yes, Cancel Ride")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.red)
                                .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
                        )
                }
                .buttonStyle(.plain)
                
                // Keep Ride Button
                Button(action: {
                    dismiss()
                }) {
                    Text("No, Keep Ride")
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
            }
        }
        .padding(32)
        .frame(maxWidth: 360)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .shadow(color: .black.opacity(0.15), radius: 20, x: 0, y: 10)
        )
        .padding(.horizontal, 20)
        .padding(.bottom, 60)
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

#Preview {
    CancelingRidePassenger()
}
