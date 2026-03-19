import MapKit
import SwiftUI

struct HomeArrivalTime: View {
    @AppStorage("isSignedIn") private var isSignedIn = false
    @State private var cameraPosition: MapCameraPosition = .userLocation(fallback: .automatic)
    @State private var passengerCoordinate = CLLocationCoordinate2D(latitude: 37.3349, longitude: -122.0090)
    @State private var driverCoordinate = CLLocationCoordinate2D(latitude: 37.3317, longitude: -122.0301)
    @State private var route: MKRoute?
    @State private var pickupNotes = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Map Background
                Map(position: $cameraPosition, interactionModes: [.pan, .zoom, .rotate]) {
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
                
                VStack(spacing: 0) {
                    topBar
                    Spacer()
                    bottomSheet
                }
            }
        }
        .onAppear {
            calculateRoute()
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
            
            NavigationLink(destination: MenuPassenger()) {
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
        .padding(.top, 4)
        .offset(y: -50)
    }
    
    // MARK: - Bottom Sheet
    private var bottomSheet: some View {
        VStack(spacing: 0) {
            RoundedRectangle(cornerRadius: 3)
                .fill(Color.gray.opacity(0.3))
                .frame(width: 40, height: 5)
                .padding(.top, 12)
            
            VStack(spacing: 20) {
                arrivalTimeSection
                driverInfoSection
                actionsSection
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
        .offset(y: 24)
        .edgesIgnoringSafeArea(.bottom)
    }
    
    // MARK: - Arrival Time Section
    private var arrivalTimeSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Arrival Time")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.black)
            
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "clock.fill")
                        .font(.system(size: 16))
                        .foregroundColor(Color(red: 0.467, green: 0, blue: 1))
                    
                    Text("8 minutes away")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(.black)
                }
                
                Spacer()
                
                Text("Est. 6:23 PM")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.gray)
            }
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(red: 0.467, green: 0, blue: 1).opacity(0.05))
            )
        }
    }
    
    // MARK: - Driver Info Section
    private var driverInfoSection: some View {
        VStack(spacing: 16) {
            HStack(spacing: 14) {
                ZStack {
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: [Color(red: 0.467, green: 0, blue: 1).opacity(0.2), Color(red: 0.6, green: 0.2, blue: 1).opacity(0.2)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 60, height: 60)
                    
                    Image(systemName: "person.fill")
                        .font(.system(size: 28))
                        .foregroundColor(Color(red: 0.467, green: 0, blue: 1))
                }
                
                VStack(alignment: .leading, spacing: 6) {
                    Text("Martha")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.black)
                    
                    HStack(spacing: 6) {
                        Image(systemName: "star.fill")
                            .font(.system(size: 11))
                            .foregroundColor(.orange)
                        Text("4.9")
                            .font(.system(size: 13, weight: .medium))
                            .foregroundColor(.black)
                        Text("•")
                            .foregroundColor(.gray)
                        Text("900 trips")
                            .font(.system(size: 13))
                            .foregroundColor(.gray)
                    }
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 8) {
                    HStack(spacing: 8) {
                        Text("Jeep Compass")
                            .font(.system(size: 13, weight: .medium))
                            .foregroundColor(.black)
                        
                        NavigationLink(destination: SafetyPassenger()) {
                            Image(systemName: "exclamationmark.triangle.fill")
                                .font(.system(size: 16))
                                .foregroundColor(.red)
                        }
                    }
                    
                    Text("340-WH56")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(Color(red: 0.467, green: 0, blue: 1))
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(
                            RoundedRectangle(cornerRadius: 6)
                                .fill(Color(red: 0.467, green: 0, blue: 1).opacity(0.1))
                        )
                }
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(red: 0.98, green: 0.98, blue: 0.98))
        )
    }
    
    // MARK: - Actions Section
    private var actionsSection: some View {
        HStack(spacing: 12) {
            HStack {
                Image(systemName: "note.text")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                
                TextField("Any pickup notes?", text: $pickupNotes)
                    .font(.system(size: 14))
                    .foregroundColor(.black)
            }
            .padding(12)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color(red: 0.96, green: 0.96, blue: 0.96))
            )
            
            NavigationLink(destination: CancelingRidePassenger()) {
                Text("Cancel")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.red)
                            .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 2)
                    )
            }
        }
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

// MARK: - Safety Page
struct SafetyPassenger: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 32) {
                Image(systemName: "shield.checkered")
                    .font(.system(size: 80))
                    .foregroundColor(Color(red: 0.467, green: 0, blue: 1))
                
                VStack(spacing: 16) {
                    Text("Safety Center")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.black)
                    
                    Text("Your safety is our priority. Access emergency features and support.")
                        .font(.system(size: 15))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)
                }
                
                VStack(spacing: 12) {
                    SafetyButton(icon: "phone.fill", title: "Emergency Call", subtitle: "Call 911")
                    SafetyButton(icon: "person.2.fill", title: "Share Trip", subtitle: "Share with contacts")
                    SafetyButton(icon: "exclamationmark.triangle.fill", title: "Report Issue", subtitle: "Report a problem")
                }
                .padding(.horizontal, 20)
                
                Spacer()
            }
            .padding(.top, 60)
            .background(Color(red: 0.98, green: 0.98, blue: 0.98))
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { dismiss() }) {
                        HStack(spacing: 8) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 16, weight: .semibold))
                            Text("Back")
                                .font(.system(size: 16))
                        }
                        .foregroundColor(Color(red: 0.467, green: 0, blue: 1))
                    }
                }
            }
        }
    }
}

struct SafetyButton: View {
    let icon: String
    let title: String
    let subtitle: String
    
    var body: some View {
        Button(action: {}) {
            HStack(spacing: 16) {
                ZStack {
                    Circle()
                        .fill(Color.red.opacity(0.1))
                        .frame(width: 50, height: 50)
                    
                    Image(systemName: icon)
                        .font(.system(size: 22))
                        .foregroundColor(.red)
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(.black)
                    
                    Text(subtitle)
                        .font(.system(size: 12))
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
                    .fill(Color.white)
                    .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 2)
            )
        }
    }
}

#Preview {
    HomeArrivalTime()
}

