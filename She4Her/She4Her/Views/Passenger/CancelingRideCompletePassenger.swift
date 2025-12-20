import SwiftUI
import MapKit

struct CancelingRideCompletePassenger: View {
    @State private var cameraPosition: MapCameraPosition = .automatic
    @State private var passengerCoordinate = CLLocationCoordinate2D(latitude: 37.3349, longitude: -122.0090)
    @State private var driverCoordinate = CLLocationCoordinate2D(latitude: 37.3317, longitude: -122.0301)
    @State private var route: MKRoute?

    var body: some View {
        ZStack {
            // Full-screen GPS map behind everything
            Map(position: $cameraPosition) {
                Marker("Passenger", coordinate: passengerCoordinate)
                    .tint(.purple)
                Marker("Driver", coordinate: driverCoordinate)
                    .tint(.blue)
                if let route {
                    MapPolyline(route.polyline)
                        .stroke(.blue, lineWidth: 3)
                }
            }
            .mapStyle(.standard(elevation: .realistic))
            .ignoresSafeArea()

            Color.white.opacity(0.0)
                .ignoresSafeArea()

            Color.black.opacity(0.04)
                .ignoresSafeArea()

            VStack(spacing: 16) {
                // Top Bar
                HStack {
                    Image(systemName: "bell")
                        .foregroundColor(.black.opacity(0.4))
                        .font(.system(size: 20, weight: .semibold))

                    Spacer()

                    Text("$43.23")
                        .font(.system(size: 24, weight: .medium))
                        .foregroundColor(.black)

                    Spacer()

                    Image(systemName: "line.horizontal.3")
                        .foregroundColor(.black.opacity(0.5))
                        .font(.system(size: 20, weight: .semibold))
                }
                .padding(.horizontal)
                .padding(.top, 8)

                // Search Bar
                HStack {
                    HStack {
                        Text("Where to go?")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(Color.black.opacity(0.44))
                        Spacer()
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.black.opacity(0.6))
                    }
                    .padding(.horizontal)
                    .frame(height: 43)
                    .background(Color(white: 0.96))
                    .cornerRadius(5)
                }
                .padding(.horizontal, 24)

                Spacer().frame(height: 4)

                // Top white card (HomePassenger style) with embedded map
                ZStack {
                    RoundedRectangle(cornerRadius: 24)
                        .fill(Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 24)
                                .stroke(Color.black.opacity(0.06), lineWidth: 1)
                        )
                        .shadow(color: .black.opacity(0.2), radius: 12, x: 0, y: 3)
                        .frame(maxWidth: .infinity)
                        .frame(height: 220)

                    Map(position: $cameraPosition) {
                        Marker("Passenger", coordinate: passengerCoordinate)
                            .tint(.purple)
                        Marker("Driver", coordinate: driverCoordinate)
                            .tint(.blue)
                        if let route {
                            MapPolyline(route.polyline)
                                .stroke(.blue, lineWidth: 3)
                        }
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 24))
                }
                .padding(.horizontal)

                Spacer()

                // Arrival Card
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text("Arrival Time")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.black)
                        Spacer()
                        Text("8 Minutes")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundColor(Color.black.opacity(0.44))
                    }

                    HStack {
                        Text("est. 6:23 p.m")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundColor(Color.black.opacity(0.44))
                        Spacer()
                    }

                    HStack {
                        Image(systemName: "car.fill")
                            .foregroundColor(.purple)
                            .font(.system(size: 24))
                        Spacer()
                        Image(systemName: "exclamationmark.triangle.fill")
                            .foregroundColor(.red)
                            .font(.system(size: 16))
                    }

                    HStack(alignment: .center, spacing: 12) {
                        Image(systemName: "person.crop.circle")
                            .foregroundColor(.black.opacity(0.44))
                            .font(.system(size: 44))
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Martha")
                                .font(.system(size: 12, weight: .semibold))
                                .foregroundColor(.purple)
                            HStack(spacing: 6) {
                                Text("4.9")
                                    .font(.system(size: 12, weight: .medium))
                                    .foregroundColor(Color.black.opacity(0.44))
                                Image(systemName: "star.fill")
                                    .foregroundColor(Color.black.opacity(0.44))
                                    .font(.system(size: 10))
                                Text("900 trips")
                                    .font(.system(size: 12, weight: .medium))
                                    .foregroundColor(Color.black.opacity(0.44))
                            }
                        }
                        Spacer()
                        VStack(alignment: .trailing, spacing: 6) {
                            Text("Jeep Compass")
                                .font(.system(size: 12, weight: .medium))
                                .foregroundColor(.black)
                            Text("340-WH56")
                                .font(.system(size: 15, weight: .medium))
                                .foregroundColor(.black)
                        }
                    }

                    HStack {
                        Text("Any Pick-up notes?")
                            .font(.system(size: 11))
                            .foregroundColor(Color.black.opacity(0.44))
                        Spacer()
                        Button(action: {}) {
                            Text("Cancel Ride")
                                .font(.system(size: 10, weight: .semibold))
                                .foregroundColor(.white)
                                .padding(.vertical, 6)
                                .padding(.horizontal, 12)
                                .background(Color.purple)
                                .cornerRadius(5)
                                .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 2)
                        }
                    }
                }
                .padding(20)
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 24)
                        .fill(Color.white)
                        .shadow(color: .black.opacity(0.15), radius: 10, x: 0, y: -2)
                )
                .padding(.horizontal)
            }

            // Success Card
            VStack(spacing: 14) {
                Text("Success!")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)

                Text("Your ride has been canceled")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)

                Button(action: {}) {
                    Text("Continue")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 45)
                        .background(Color.purple)
                        .cornerRadius(5)
                        .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2)
                }
            }
            .padding(20)
            .frame(maxWidth: 320)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white)
                    .shadow(radius: 4)
            )
            .padding()
            .zIndex(1)
        }
        .onAppear {
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

            MKDirections(request: request).calculate { response, error in
                if let route = response?.routes.first { self.route = route }
            }
        }
    }
}

#Preview {
    CancelingRideCompletePassenger()
}

