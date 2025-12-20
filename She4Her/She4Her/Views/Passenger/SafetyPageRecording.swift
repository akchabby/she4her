import SwiftUI
import MapKit

struct SafetyPageRecording: View {
    @State private var cameraPosition: MapCameraPosition = .automatic
    @State private var passengerCoordinate = CLLocationCoordinate2D(latitude: 37.3349, longitude: -122.0090) // Apple Park (sample)
    @State private var driverCoordinate = CLLocationCoordinate2D(latitude: 37.3317, longitude: -122.0301) // Nearby (sample)
    @State private var route: MKRoute?
    @State private var isRecording = false
    
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
                        .foregroundColor(Color.black.opacity(0.5))
                        .padding(.trailing, 20)
                }
                .padding(.top, 40)
                
                Text("$43.23")
                    .font(.system(size: 24, weight: .medium))
                    .foregroundColor(.black)
                    .padding(.top, 20)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color(white: 0.96))
                        .frame(width: 259, height: 43)
                    
                    HStack {
                        Text("Where to go?")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(Color.black.opacity(0.44))
                            .padding(.leading, 80)
                        
                        Spacer()
                        
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .frame(width: 18, height: 18)
                            .foregroundColor(Color(white: 0.11))
                            .padding(.trailing, 14)
                    }
                }
                .padding(.top, 20)
                
                Spacer()
                ZStack {
                    Rectangle()
                        .fill(Color.white)
                        .frame(width: 393, height: 305)
                        .cornerRadius(54)
                        .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 4)
                    
                    VStack {
                        HStack {
                            ZStack {
                                Circle()
                                    .fill(Color.purple)
                                    .frame(width: 50, height: 48)
                                
                                Image(systemName: "phone.fill")
                                    .resizable()
                                    .frame(width: 26, height: 25)
                                    .foregroundColor(.white)
                            }
                            
                            Text("911 Speed Dial")
                                .font(.system(size: 12, weight: .bold))
                                .foregroundColor(Color(white: 0.12))
                                .padding(.leading, 10)
                            
                            Spacer()
                        }
                        .padding(.top, 20)
                        
                        HStack {
                            ZStack {
                                Circle()
                                    .fill(Color.purple)
                                    .frame(width: 50, height: 48)
                                
                                Image(systemName: "record.circle")
                                    .resizable()
                                    .frame(width: 26, height: 25)
                                    .foregroundColor(isRecording ? .green : .white)
                            }
                            .onTapGesture {
                                isRecording.toggle()
                            }
                            
                            Text("Record")
                                .font(.system(size: 12, weight: .bold))
                                .foregroundColor(.black)
                                .padding(.leading, 10)
                            
                            Spacer()
                        }
                        .padding(.top, 20)
                        
                        HStack {
                            ZStack {
                                Circle()
                                    .fill(Color.purple)
                                    .frame(width: 50, height: 48)
                                
                                Image(systemName: "location.fill")
                                    .resizable()
                                    .frame(width: 26, height: 25)
                                    .foregroundColor(.white)
                            }
                            
                            Text("Share Location")
                                .font(.system(size: 12, weight: .bold))
                                .foregroundColor(.black)
                                .padding(.leading, 10)
                            
                            Spacer()
                        }
                        .padding(.top, 20)
                    }
                    .padding(.horizontal, 20)
                }
                .padding(.bottom, 16)
            }
            .padding(.top, 16)
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
    SafetyPageRecording()
}
