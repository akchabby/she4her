import SwiftUI
import MapKit

struct CancelingRidePassenger: View {
    @State private var cameraPosition: MapCameraPosition = .automatic
    @State private var passengerCoordinate = CLLocationCoordinate2D(latitude: 37.3349, longitude: -122.0090) // Apple Park (sample)
    @State private var driverCoordinate = CLLocationCoordinate2D(latitude: 37.3317, longitude: -122.0301) // Nearby (sample)
    @State private var route: MKRoute?

    @Environment(\.dismiss) private var dismiss
    var body: some View {
        ZStack {
            // Live map background
            Map(position: $cameraPosition) {
                // Passenger marker
                Marker("Passenger", coordinate: passengerCoordinate)
                    .tint(.purple)
                // Driver marker
                Marker("Driver", coordinate: driverCoordinate)
                    .tint(.blue)
                // Route overlay
                if let route {
                    MapPolyline(route.polyline)
                        .stroke(.blue, lineWidth: 4)
                }
            }
            .mapStyle(.standard(elevation: .realistic))
            .ignoresSafeArea()

            VStack {
                HStack {
                    Spacer()
                    Image(systemName: "line.horizontal.3")
                        .resizable()
                        .frame(width: 36, height: 24)
                        .padding()
                }
                .frame(height: 48)
                
                Text("$43.23")
                    .font(.system(size: 24, weight: .medium))
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, 16)
                
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color(white: 0.96))
                    .frame(width: 259, height: 43)
                    .overlay(
                        HStack {
                            Text("Where to go?")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(Color.black.opacity(0.44))
                            Spacer()
                            Image(systemName: "magnifyingglass")
                                .resizable()
                                .frame(width: 18, height: 18)
                                .foregroundColor(Color(white: 0.11))
                        }
                        .padding(.horizontal, 16)
                    )
                    .padding(.top, 16)
                
                Spacer()
                
                ZStack {
                    Rectangle()
                        .fill(Color.white)
                        .frame(width: 395, height: 305)
                        .cornerRadius(54)
                        .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 4)
                    
                    VStack(spacing: 16) {
                        Image(systemName: "exclamationmark.triangle")
                            .resizable()
                            .frame(width: 57, height: 56)
                            .foregroundColor(Color.purple)
                        
                        Text("Are you sure you want to cancel your ride?")
                            .font(.system(size: 13, weight: .medium))
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 16)
                        
                        HStack(spacing: 16) {
                            Button(action: {
                                dismiss()
                            }) {
                                Text("Do Not Cancel")
                                    .font(.system(size: 11, weight: .semibold))
                                    .foregroundColor(Color.purple)
                                    .frame(width: 117.61, height: 37)
                                    .background(Color.white)
                                    .cornerRadius(5)
                                    .shadow(color: Color.purple.opacity(0.3), radius: 4, x: 0, y: 4)
                            }
                            
                            NavigationLink(destination: CancelingRideCompletePassenger()) {
                                Text("Cancel Ride")
                                    .font(.system(size: 11, weight: .semibold))
                                    .foregroundColor(.white)
                                    .frame(width: 117.61, height: 37)
                                    .background(Color.purple)
                                    .cornerRadius(5)
                            }
                        }
                    }
                    .padding(.top, 16)
                }
                .padding(.bottom, 16)
            }
        }
        .onAppear {
            // Fit both points
            let center = CLLocationCoordinate2D(
                latitude: (passengerCoordinate.latitude + driverCoordinate.latitude) / 2,
                longitude: (passengerCoordinate.longitude + driverCoordinate.longitude) / 2
            )
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
            cameraPosition = .region(region)

            // Request route
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
}

#Preview {
    CancelingRidePassenger()
}
