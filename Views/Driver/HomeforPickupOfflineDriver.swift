import SwiftUI
import MapKit
import Combine

struct HomeforPickupOfflineDriver: View {
    @State private var isOnline = false
    @AppStorage("isSignedIn") private var isSignedIn = false
    @Environment(\.dismiss) private var dismiss
    
    @StateObject private var locationManager = LocationManager()
    @State private var mapPosition: MapCameraPosition = .userLocation(fallback: .automatic)
    @State private var goToOnlinePage = false
    @State private var showMenuSheet = false
    
    var body: some View {
        NavigationStack {
            NavigationLink(destination: HomeBeforePickupDriverOnline(), isActive: $goToOnlinePage) { EmptyView() }
            
            ZStack {
                // Map Background
                Map(position: $mapPosition) {
                    if let location = locationManager.userLocation {
                        Annotation("Me", coordinate: location.coordinate) {
                            ZStack {
                                Circle()
                                    .fill(Color.white)
                                    .frame(width: 36, height: 36)
                                    .shadow(color: .black.opacity(0.3), radius: 4)
                                
                                Circle()
                                    .fill(Color.gray)
                                    .frame(width: 24, height: 24)
                                
                                Image(systemName: "car.fill")
                                    .font(.system(size: 12, weight: .semibold))
                                    .foregroundColor(.white)
                            }
                        }
                        
                        // Greyed out radius when offline
                        MapCircle(center: location.coordinate, radius: 1000)
                            .foregroundStyle(Color.gray.opacity(0.05))
                            .stroke(Color.gray.opacity(0.3), lineWidth: 2)
                    }
                }
                .mapControls {
                    MapUserLocationButton()
                    MapCompass()
                }
                .mapStyle(.standard)
                .edgesIgnoringSafeArea(.all)
                
                // Nearby riders overlay (greyed out when offline)
                if let location = locationManager.userLocation {
                    nearbyRidersOverlay
                }
                
                // Top Bar
                VStack {
                    topBar
                    Spacer()
                }
                
                // Bottom Sheet
                VStack {
                    Spacer()
                    bottomSheet
                }
            }
        }
        .sheet(isPresented: $showMenuSheet) {
            MenuDriver()
        }
        .background(Color(.systemGroupedBackground))
        .onChange(of: isOnline) { newValue in
            if newValue {
                goToOnlinePage = true
            }
        }
        .onChange(of: locationManager.userLocation) { newLocation in
            if let location = newLocation {
                updateMapPosition(for: location)
            }
        }
        .onAppear {
            locationManager.requestAuthorization()
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
        .padding(.top, 8)
    }
    
    // MARK: - Nearby Riders Overlay
    private var nearbyRidersOverlay: some View {
        ZStack {
            // Greyed out nearby rider indicators
            greyedRiderIndicator(minutes: 10, xOffset: -70, yOffset: -50)
            greyedRiderIndicator(minutes: 4, xOffset: 80, yOffset: 20)
            greyedRiderIndicator(minutes: 15, xOffset: -30, yOffset: 90)
        }
        .offset(y: -120)
    }
    
    private func greyedRiderIndicator(minutes: Int, xOffset: CGFloat, yOffset: CGFloat) -> some View {
        VStack(spacing: 4) {
            Image(systemName: "figure.wave")
                .font(.system(size: 14))
                .foregroundColor(.white)
                .padding(6)
                .background(
                    Circle()
                        .fill(Color.gray.opacity(0.6))
                )
            
            Text("\(minutes) min")
                .font(.system(size: 9, weight: .medium))
                .foregroundColor(.white)
                .padding(.horizontal, 6)
                .padding(.vertical, 3)
                .background(
                    Capsule()
                        .fill(Color.gray.opacity(0.6))
                )
        }
        .offset(x: xOffset, y: yOffset)
    }
    
    // MARK: - Bottom Sheet
    private var bottomSheet: some View {
        VStack(spacing: 0) {
            // Drag Handle
            RoundedRectangle(cornerRadius: 3)
                .fill(Color.gray.opacity(0.3))
                .frame(width: 40, height: 5)
                .padding(.top, 12)
            
            VStack(spacing: 24) {
                // Offline/Online Toggle
                toggleSection
                
                // Offline Message
                offlineMessageCard
            }
            .padding(.horizontal, 20)
            .padding(.top, 16)
            .padding(.bottom, 32)
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
    
    // MARK: - Offline Message Card
    private var offlineMessageCard: some View {
        VStack(spacing: 16) {
            // Icon
            Image(systemName: "moon.zzz.fill")
                .font(.system(size: 48))
                .foregroundColor(.gray)
            
            // Message
            VStack(spacing: 8) {
                Text("You're Offline")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.black)
                
                Text("You cannot access riders. Select Online to see nearby riders and start earning.")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
            }
            
            // Go Online Button
            Button(action: {
                withAnimation(.spring(response: 0.3)) {
                    isOnline = true
                    goToOnlinePage = true
                }
            }) {
                HStack(spacing: 8) {
                    Image(systemName: "antenna.radiowaves.left.and.right")
                        .font(.system(size: 16))
                    Text("Go Online")
                        .font(.system(size: 16, weight: .semibold))
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(red: 0.467, green: 0, blue: 1))
                        .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 4)
                )
            }
            .padding(.horizontal, 40)
        }
        .padding(.vertical, 24)
    }
    
    // MARK: - Helper
    private func updateMapPosition(for location: CLLocation) {
        let span = MKCoordinateSpan(latitudeDelta: 0.015, longitudeDelta: 0.015)
        let region = MKCoordinateRegion(center: location.coordinate, span: span)
        withAnimation {
            mapPosition = .region(region)
        }
    }
}

#Preview {
    HomeforPickupOfflineDriver()
}
