import SwiftUI
import MapKit
import Combine

struct HomeforPickupOfflineDriver: View {
    @State private var isOnline = false
    @AppStorage("isSignedIn") private var isSignedIn = false
    @Environment(\.dismiss) private var dismiss
    
    @StateObject private var locationManager = DriverLocationManager()
    @State private var mapPosition: MapCameraPosition = .userLocation(fallback: .automatic)
    
    var body: some View {
        VStack(spacing: 0) {
            // Header bar (match HomePageDriver sizes)
            HStack {
                Image(systemName: "bell")
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundColor(.black)
                Spacer()
                Text("$205.12")
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundColor(.black)
                Spacer()
                Image(systemName: "line.3.horizontal")
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundColor(Color.purple)
            }
            .padding(.horizontal, 20)
            .frame(height: 12)
            .background(Color.white)
            .padding(.top, -120)
            
            // Map area
            ZStack {
                Map(position: $mapPosition) {
                    UserAnnotation()
                    if let coord = locationManager.lastLocation?.coordinate {
                        MapCircle(center: coord, radius: 1000)
                            .stroke(Color.purple, lineWidth: 3)
                    }
                }
                .mapStyle(.standard)
                .frame(maxWidth: .infinity)
                .frame(height: 280)
                .clipped()

                // Purple radius circle overlay (visual)
                Circle()
                    .stroke(Color.purple, lineWidth: 3)
                    .frame(width: 300, height: 300)

                // Me marker (visual)
                VStack(spacing: 4) {
                    Image(systemName: "mappin.circle.fill")
                        .font(.system(size: 28))
                        .foregroundColor(.black)
                    Text("Me")
                        .foregroundColor(.black)
                        .font(.system(size: 12))
                }
                .offset(x: 60, y: -20)

                // Time chips
                HStack {
                    Text("10 min").chip
                    Spacer()
                    Text("4 min").chip
                }
                .padding(.horizontal, 36)
                .offset(y: -80)

                Text("15 min").chip
                    .offset(x: -40, y: 20)

                // Center dot inside circle
                Circle()
                    .fill(Color.purple)
                    .frame(width: 10, height: 10)
                    .offset(x: -20, y: 40)
            }
            .background(Color.white)
            
            // Bottom card
            VStack(spacing: 16) {
                // Custom Offline/Online toggle row (Offline red, Online gray)
                HStack {
                    Spacer()
                    Text("Offline")
                        .foregroundColor(.red)
                    ZStack {
                        Capsule()
                            .stroke(Color.purple, lineWidth: 2)
                            .frame(width: 56, height: 32)
                        Circle()
                            .fill(Color.purple)
                            .frame(width: 24, height: 24)
                            .offset(x: isOnline ? 10 : -10)
                            .animation(.easeInOut(duration: 0.2), value: isOnline)
                            .onTapGesture { isOnline.toggle() }
                    }
                    Text("Online")
                        .foregroundColor(.gray)
                    Spacer()
                }
                .padding(.top, 8)
                
                // Offline message
                VStack(alignment: .leading, spacing: 6) {
                    Text("Your are offline")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.black)
                    Text("You can not access riders. Select Online to see nearby riders.")
                        .font(.system(size: 14))
                        .foregroundColor(.black.opacity(0.44))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 4)
            }
            .padding(.horizontal, 16)
            .padding(.top, 12)
            .padding(.bottom, 16)
            .background(
                RoundedRectangle(cornerRadius: 24)
                    .fill(Color.white)
                    .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: -2)
            )
        }
        .background(Color(.systemGroupedBackground))
        .onChange(of: isOnline) { newValue in
            if newValue {
                dismiss()
            }
        }
        .onReceive(locationManager.$lastLocation.compactMap { $0 }) { location in
            setCloseRegion(center: location.coordinate)
        }
        .onAppear {
            locationManager.requestAuthorization()
        }
    }
    
    private func setCloseRegion(center: CLLocationCoordinate2D) {
        let span = MKCoordinateSpan(latitudeDelta: 0.0015, longitudeDelta: 0.0015)
        let region = MKCoordinateRegion(center: center, span: span)
        mapPosition = .region(region)
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
    HomeforPickupOfflineDriver()
}

