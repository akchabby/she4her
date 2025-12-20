import SwiftUI
import MapKit

struct PickUpNotesConfirmedPassenger: View {
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
                        .foregroundColor(Color(white: 0.117))
                        .padding(.trailing, 16)
                }
                .padding(.top, 41)
                
                Text("$43.23")
                    .font(.system(size: 24, weight: .medium, design: .default))
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, 12)
                
                ZStack {
                    Rectangle()
                        .fill(Color(white: 0.961))
                        .frame(width: 259, height: 43)
                        .cornerRadius(5)
                    
                    HStack {
                        Text("Where to go?")
                            .font(.system(size: 16, weight: .medium, design: .default))
                            .foregroundColor(Color.black.opacity(0.44))
                            .padding(.leading, 80)
                        
                        Spacer()
                        
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .frame(width: 18, height: 18)
                            .foregroundColor(Color(white: 0.114))
                            .padding(.trailing, 14)
                    }
                }
                .padding(.top, 10)
                
                Spacer()
                
                ZStack {
                    Rectangle()
                        .fill(Color.white)
                        .frame(width: 393, height: 305)
                        .cornerRadius(54)
                    
                    VStack(spacing: 14) {
                        // Title
                        Text("Success!")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            .multilineTextAlignment(.center)
                        
                        // Message
                        Text("Your feedback has been shared with the driver!")
                            .font(.system(size: 13))
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 24)
                        
                        // Safety notice pill
                        HStack(spacing: 8) {
                            Image(systemName: "shield")
                                .resizable()
                                .frame(width: 16, height: 18)
                                .foregroundColor(Color(red: 0.467, green: 0, blue: 1))
                            Text("Driver may record audio for added safety.")
                                .font(.system(size: 11))
                                .foregroundColor(.black)
                        }
                        .padding(.vertical, 8)
                        .padding(.horizontal, 12)
                        .background(
                            RoundedRectangle(cornerRadius: 22)
                                .fill(Color.white)
                                .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                        )
                        
                        // Continue button
                        Button(action: { dismiss() }) {
                            Text("Continue")
                                .font(.system(size: 13, weight: .semibold))
                                .foregroundColor(.white)
                                .frame(maxWidth: 160)
                                .frame(height: 36)
                                .background(Color(red: 0.467, green: 0, blue: 1))
                                .cornerRadius(6)
                                .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2)
                        }
                        .padding(.top, 6)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 24)
                }
                .padding(.bottom, 20)
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
    PickUpNotesConfirmedPassenger()
}
