import MapKit
import SwiftUI

struct HomeArrivalTime: View {
    @AppStorage("isSignedIn") private var isSignedIn = false
    @State private var cameraPosition: MapCameraPosition = .userLocation(fallback: .automatic)
    @State private var showsUserLocation: Bool = true
    
    @State private var passengerCoordinate = CLLocationCoordinate2D(latitude: 37.3349, longitude: -122.0090) // Apple Park (sample)
    @State private var driverCoordinate = CLLocationCoordinate2D(latitude: 37.3317, longitude: -122.0301) // Nearby (sample)
    @State private var route: MKRoute?
    
    var body: some View {
        ZStack {
            Map(position: $cameraPosition, interactionModes: [.pan, .zoom, .rotate]) {
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
            .tint(.purple)
            
            VStack {
                VStack(spacing: 8) {
                    HStack {
                        Button(action: {
                        }) {
                            Image(systemName: "bell")
                                .font(.system(size: 22, weight: .semibold))
                                .foregroundColor(.black)
                        }
                        .padding(.leading)

                        Spacer()

                        NavigationLink(destination: MenuPassenger()) {
                            MenuIconPassenger()
                                .frame(width: 36, height: 24)
                        }
                        .buttonStyle(.plain)
                        .padding()
                    }

                    Button("Sign Out") {
                        isSignedIn = false
                    }
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(.red)

                    Text("$43.23")
                        .font(.system(size: 24, weight: .medium))
                        .foregroundColor(.black)
                        .padding(.top, 4)
                }
                .padding(.top, 8)
                .padding(.bottom, 12)
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
                
                ZStack {
                    Rectangle()
                        .fill(Color(white: 0.96))
                        .frame(width: 259, height: 43)
                        .cornerRadius(5)
                    
                    HStack {
                        Text("Where to go?")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(Color.black.opacity(0.44))
                            .padding(.leading, 77)
                        
                        Spacer()
                        
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .frame(width: 18, height: 18)
                            .foregroundColor(Color.black.opacity(0.7))
                            .padding(.trailing, 90)
                    }
                }
                .padding(.top, 20)
                
                Spacer()
                
                ZStack {
                    Rectangle()
                        .fill(Color.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 200)
                        .cornerRadius(54)
                        .shadow(color: Color.black.opacity(0.08), radius: 10, x: 0, y: -2)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Arrival Time")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.black)
                        
                        HStack {
                            Text("8 minutes away")
                                .font(.system(size: 12, weight: .semibold))
                                .foregroundColor(Color.black.opacity(0.44))
                            
                            Spacer()
                            
                            Text("est. 6:23 p.m")
                                .font(.system(size: 12, weight: .semibold))
                                .foregroundColor(Color.black.opacity(0.44))
                        }
                        
                        HStack {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .background(Color.gray)
                                .clipShape(Circle())
                            
                            VStack(alignment: .leading) {
                                Text("Martha")
                                    .font(.system(size: 12, weight: .semibold))
                                    .foregroundColor(Color.purple)
                                
                                HStack {
                                    Text("4.9")
                                        .font(.system(size: 12, weight: .medium))
                                        .foregroundColor(Color.black.opacity(0.44))
                                    
                                    Image(systemName: "star.fill")
                                        .resizable()
                                        .frame(width: 9, height: 9)
                                        .foregroundColor(Color.black.opacity(0.44))
                                    
                                    Text("900 trips")
                                        .font(.system(size: 12, weight: .medium))
                                        .foregroundColor(Color.black.opacity(0.44))
                                }
                            }
                            
                            Spacer()
                            
                            VStack(alignment: .trailing, spacing: 8) {
                                HStack(spacing: 12) {
                                    Text("Jeep Compass")
                                        .font(.system(size: 12, weight: .medium))
                                        .foregroundColor(.black)
                                    NavigationLink(destination: SafetyPassenger()) {
                                        AlertTriangle()
                                            .frame(width: 18, height: 18)
                                    }
                                    .buttonStyle(.plain)
                                    .padding(.trailing, 2)
                                }
                                
                                Text("340-WH56")
                                    .font(.system(size: 15, weight: .medium))
                                    .foregroundColor(.black)
                                    .padding(.top, 4)
                            }
                        }
                        
                        HStack {
                            NavigationLink(destination: PickUpNotesPassenger()) {
                                Text("Any Pick-up notes?")
                                    .font(.system(size: 11))
                                    .foregroundColor(Color.black.opacity(0.44))
                            }
                            .buttonStyle(.plain)
                            
                            Spacer()
                            
                            NavigationLink(destination: CancelingRidePassenger()) {
                                ZStack {
                                    Rectangle()
                                        .fill(Color.purple)
                                        .frame(width: 76, height: 25)
                                        .cornerRadius(5)
                                        .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 4)
                                    
                                    Text("Cancel Ride")
                                        .font(.system(size: 10, weight: .semibold))
                                        .foregroundColor(.white)
                                }
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                
                }
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

struct SafetyPassenger: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("Safety Center")
                .font(.system(size: 22, weight: .bold))
            Text("This is a placeholder safety page. Add emergency contacts, share trip, or report options here.")
                .font(.system(size: 14))
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
        }
        .padding()
        .navigationTitle("Safety")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    HomeArrivalTime()
}

struct AlertTriangle: View {
    var body: some View {
        Image(systemName: "exclamationmark.triangle.fill")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .foregroundColor(.red)
            .frame(width: 20, height: 20)
    }
}

#Preview("AlertTriangle") {
    AlertTriangle()
}

