import SwiftUI
import MapKit
import Combine

final class DriverLocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var authorizationStatus: CLAuthorizationStatus
    @Published var lastLocation: CLLocation?
    private let manager = CLLocationManager()

    override init() {
        self.authorizationStatus = CLLocationManager.authorizationStatus()
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.distanceFilter = kCLDistanceFilterNone
    }

    func requestAuthorization() {
        if authorizationStatus == .notDetermined {
            manager.requestWhenInUseAuthorization()
        }
        manager.startUpdatingLocation()
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus
        if authorizationStatus == .authorizedAlways || authorizationStatus == .authorizedWhenInUse {
            self.manager.startUpdatingLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastLocation = locations.last
    }
}

struct HomePageDriver: View {
    @State private var isOnline = true
    @State private var navigateToOffline = false
    @State private var showMenuSheet = false

    @StateObject private var locationManager = DriverLocationManager()
    @State private var mapPosition: MapCameraPosition = .userLocation(fallback: .automatic)
    
    private func setCloseRegion(center: CLLocationCoordinate2D) {
        // Closer zoom: smaller deltas mean closer view
        let span = MKCoordinateSpan(latitudeDelta: 0.0015, longitudeDelta: 0.0015)
        let region = MKCoordinateRegion(center: center, span: span)
        mapPosition = .region(region)
    }

    var body: some View {
        NavigationStack {
            ZStack {
                // Full-screen live Map background following user location
                Map(position: $mapPosition) {
                    UserAnnotation()
                    if let coord = locationManager.lastLocation?.coordinate {
                        MapCircle(center: coord, radius: 1000)
                            .stroke(Color.purple, lineWidth: 3)
                    }
                }
                .mapControls {
                    MapUserLocationButton()
                }
                .mapStyle(.standard)
                .ignoresSafeArea()

                // Map visual overlays: chips and "Me" label (visual only)
                ZStack {
                    GeometryReader { geo in
                        let size = min(geo.size.width, geo.size.height)
                        let circleSize = size * 0.78
                        // Removed fixed circle stroke overlay here

                        // Decorative time chips around the circle
                        Group {
                            Text("10 min").chip
                                .position(x: geo.size.width * 0.28, y: geo.size.height * 0.34)
                            Text("4 min").chip
                                .position(x: geo.size.width * 0.80, y: geo.size.height * 0.42)
                            Text("15 min").chip
                                .position(x: geo.size.width * 0.50, y: geo.size.height * 0.60)
                        }

                        // "Me" label near the user marker
                        VStack(spacing: 6) {
                            ZStack {
                                Circle()
                                    .fill(Color.white)
                                    .frame(width: 28, height: 28)
                                Image(systemName: "mappin.circle")
                                    .font(.system(size: 24, weight: .bold))
                                    .foregroundColor(.black)
                            }
                            Text("Me")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(.black)
                        }
                        .position(x: geo.size.width * 0.62, y: geo.size.height * 0.46)
                    }
                }
                .allowsHitTesting(false)

                VStack(spacing: 0) {
                    NavigationLink(destination: HomeforPickupOfflineDriver(), isActive: $navigateToOffline) { EmptyView() }

                    // Header area with white rectangle under icons/text
                    ZStack(alignment: .top) {
                        RoundedRectangle(cornerRadius: 0)
                            .fill(Color.white)
                            .frame(height: 220)
                            .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
                            .ignoresSafeArea(edges: .top)

                        // Top row: bell and menu
                        HStack {
                            Image(systemName: "bell")
                                .font(.system(size: 22, weight: .semibold))
                                .foregroundColor(.black)
                            Spacer()
                            Button(action: { showMenuSheet = true }) {
                                Image(systemName: "line.3.horizontal")
                                    .font(.system(size: 22, weight: .semibold))
                                    .foregroundColor(Color.purple)
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 16)
                        .frame(height: 220, alignment: .top)

                        // Centered balance lower in the header
                        VStack {
                            Spacer()
                            Text("$205.12")
                                .font(.system(size: 24, weight: .semibold))
                                .foregroundColor(.black)
                                .padding(.bottom, 175)
                        }
                        .frame(height: 220)
                    }

                    Spacer(minLength: 0)

                    VStack(spacing: 16) {
                        HStack {
                            Spacer()
                            Text("Offline")
                                .foregroundColor(.black)
                            ZStack(alignment: isOnline ? .trailing : .leading) {
                                Capsule()
                                    .stroke(Color.purple, lineWidth: 3)
                                    .background(Capsule().fill(Color.white))
                                    .frame(width: 64, height: 36)
                                Circle()
                                    .fill(Color.purple)
                                    .frame(width: 28, height: 28)
                                    .shadow(color: Color.purple.opacity(0.35), radius: 4, x: 0, y: 2)
                                    .padding(4)
                            }
                            .animation(.easeInOut(duration: 0.2), value: isOnline)
                            .onTapGesture { isOnline.toggle() }
                            Text("Online")
                                .foregroundColor(.green)
                            Spacer()
                        }
                        .padding(.top, 8)

                        HStack {
                            Text("Nearby Passengers")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.black)
                            Spacer()
                        }

                        RequestRow(price: "$16", duration: "20 minute drive", distance: "15 minutes away")
                        Divider().overlay(Color.black.opacity(0.08)).padding(.leading)
                        RequestRow(price: "$18", duration: "15 minute drive", distance: "15 minutes away")
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 2)
                    .padding(.bottom, 16)
                    .background(
                        RoundedRectangle(cornerRadius: 28, style: .continuous)
                            .fill(Color.white)
                            .shadow(color: Color.black.opacity(0.08), radius: 12, x: 0, y: -2)
                    )
                }
                .onReceive(locationManager.$lastLocation.compactMap { $0 }) { location in
                    setCloseRegion(center: location.coordinate)
                }
                .onChange(of: isOnline) { newValue in
                    if newValue == false {
                        navigateToOffline = true
                    }
                }
                .onAppear {
                    locationManager.requestAuthorization()
                }
            }
        }
        .background(Color(.systemGroupedBackground))
        .sheet(isPresented: $showMenuSheet) {
            MenuDriver()
        }
    }
}

struct RideRequestCard: View {
    let price: String
    let duration: String
    let distance: String

    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(price)
                        .font(.headline)
                    Text(duration)
                        .foregroundColor(.gray)
                    Text(distance)
                        .foregroundColor(.gray)
                }

                Spacer()

                HStack {
                    Button("Decline") {
                        // Decline action
                    }
                    .foregroundColor(.black)

                    Button("Accept") {
                        // Accept action
                    }
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.purple)
                    .cornerRadius(5)
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 4)
        }
    }
}

private struct RequestRow: View {
    let price: String
    let duration: String
    let distance: String

    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 4) {
                Text(price)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.black)
                Text(duration)
                    .font(.system(size: 13))
                    .foregroundColor(.gray)
                Text(distance)
                    .font(.system(size: 13))
                    .foregroundColor(.gray)
            }
            Spacer()

            // trailing controls
            VStack(alignment: .trailing, spacing: 8) {
                Button(action: {}) {
                    Image(systemName: "xmark")
                        .foregroundColor(.black)
                }

                HStack(spacing: 12) {
                    Button("Decline") {}
                        .foregroundColor(.black)
                        .font(.system(size: 13, weight: .medium))
                    Button(action: {}) {
                        Text("Accept")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundColor(.white)
                            .padding(.vertical, 6)
                            .padding(.horizontal, 14)
                            .background(Color.purple)
                            .cornerRadius(8)
                            .shadow(color: Color.purple.opacity(0.35), radius: 6, x: 0, y: 3)
                    }
                }
            }
        }
    }
}

private extension Text {
    var chip: some View {
        self
            .font(.system(size: 12, weight: .semibold))
            .foregroundColor(.white)
            .padding(.vertical, 6)
            .padding(.horizontal, 10)
            .background(Capsule().fill(Color.purple))
    }
}

#Preview {
    HomePageDriver()
}

