import SwiftUI
import MapKit

struct HomeRideCompleteDriver: View {
    @State private var rideComplete = true
    @State private var showNextRideRequest = false
    @State private var showMenuSheet = false
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Map Background
                Map(coordinateRegion: $region, showsUserLocation: true)
                    .edgesIgnoringSafeArea(.all)
                
                // Destination marker
                VStack {
                    Spacer()
                    destinationMarkerOverlay
                        .offset(y: -250)
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
                Text("$221.12")
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
    
    // MARK: - Destination Marker Overlay
    private var destinationMarkerOverlay: some View {
        ZStack {
            Circle()
                .stroke(Color.green.opacity(0.3), lineWidth: 3)
                .fill(Color.green.opacity(0.05))
                .frame(width: 280, height: 280)
            
            // Destination pin
            VStack(spacing: 4) {
                Image(systemName: "mappin.circle.fill")
                    .font(.system(size: 40))
                    .foregroundColor(.green)
                    .background(
                        Circle()
                            .fill(Color.white)
                            .frame(width: 44, height: 44)
                    )
                
                Text("Arrived!")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(
                        Capsule()
                            .fill(Color.green)
                            .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2)
                    )
            }
            
            // Car marker
            Image(systemName: "car.fill")
                .font(.system(size: 20))
                .foregroundColor(.white)
                .padding(12)
                .background(
                    Circle()
                        .fill(Color(red: 0.467, green: 0, blue: 1))
                        .shadow(color: .black.opacity(0.3), radius: 8, x: 0, y: 4)
                )
                .offset(x: 90, y: 60)
        }
    }
    
    // MARK: - Bottom Sheet
    private var bottomSheet: some View {
        VStack(spacing: 0) {
            // Drag Handle
            RoundedRectangle(cornerRadius: 3)
                .fill(Color.gray.opacity(0.3))
                .frame(width: 40, height: 5)
                .padding(.top, 12)
            
            VStack(spacing: 20) {
                // Ride Complete Status
                rideStatusSection
                
                // Destination Info
                destinationInfoCard
                
                // Next Ride Request
                if showNextRideRequest {
                    nextRideRequestCard
                } else {
                    lookingForNextRideCard
                }
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
        .onAppear {
            // Simulate next ride request after 5 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                showNextRideRequest = true
            }
        }
    }
    
    // MARK: - Ride Status Section
    private var rideStatusSection: some View {
        HStack {
            HStack(spacing: 12) {
                Text("Ride In Progress")
                    .font(.system(size: 13, weight: !rideComplete ? .bold : .medium))
                    .foregroundColor(!rideComplete ? .red : .gray)
                
                ZStack {
                    Capsule()
                        .fill(rideComplete ? Color.green.opacity(0.2) : Color.red.opacity(0.2))
                        .frame(width: 50, height: 28)
                    
                    Circle()
                        .fill(rideComplete ? Color.green : Color.red)
                        .frame(width: 22, height: 22)
                        .offset(x: rideComplete ? 12 : -12)
                }
                
                Text("Ride Complete")
                    .font(.system(size: 13, weight: rideComplete ? .bold : .medium))
                    .foregroundColor(rideComplete ? .green : .gray)
            }
            
            Spacer()
            
            HStack(spacing: 6) {
                Circle()
                    .fill(Color.green)
                    .frame(width: 8, height: 8)
                Text("Online")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(.green)
            }
        }
    }
    
    // MARK: - Destination Info Card
    private var destinationInfoCard: some View {
        HStack {
            VStack(alignment: .leading, spacing: 6) {
                Text("Destination")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                
                Text("234 Main Street")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.black)
            }
            
            Spacer()
            
            VStack(spacing: 4) {
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 32))
                    .foregroundColor(.green)
                
                Text("Arrived!")
                    .font(.system(size: 13, weight: .bold))
                    .foregroundColor(.green)
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.green.opacity(0.1))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.green.opacity(0.3), lineWidth: 1)
                )
        )
    }
    
    // MARK: - Looking for Next Ride Card
    private var lookingForNextRideCard: some View {
        VStack(spacing: 16) {
            Image(systemName: "antenna.radiowaves.left.and.right")
                .font(.system(size: 40))
                .foregroundColor(Color(red: 0.467, green: 0, blue: 1))
            
            VStack(spacing: 6) {
                Text("Looking for your next ride...")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.black)
                
                Text("We'll notify you when a new request comes in")
                    .font(.system(size: 13))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
            }
        }
        .padding(.vertical, 24)
    }
    
    // MARK: - Next Ride Request Card
    private var nextRideRequestCard: some View {
        VStack(spacing: 16) {
            // Header
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("New Ride Request")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.black)
                    
                    Text("Nearby passenger")
                        .font(.system(size: 13))
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                Button(action: {
                    showNextRideRequest = false
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 24))
                        .foregroundColor(.gray)
                }
            }
            
            // Ride Details
            VStack(spacing: 12) {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Estimated Fare")
                            .font(.system(size: 11))
                            .foregroundColor(.gray)
                        Text("$23.00")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(Color(red: 0.467, green: 0, blue: 1))
                    }
                    
                    Spacer()
                }
                
                Divider()
                
                HStack(spacing: 16) {
                    DetailItemSmall(icon: "car.fill", value: "12 min drive")
                    DetailItemSmall(icon: "location.fill", value: "6 min away")
                }
            }
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(red: 0.98, green: 0.98, blue: 0.98))
            )
            
            // Action Buttons
            HStack(spacing: 12) {
                Button(action: {
                    showNextRideRequest = false
                }) {
                    Text("Decline")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(Color(red: 0.467, green: 0, blue: 1))
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(red: 0.467, green: 0, blue: 1), lineWidth: 2)
                        )
                }
                
                Button(action: {
                    // Accept next ride
                }) {
                    Text("Accept")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(red: 0.467, green: 0, blue: 1))
                                .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 4)
                        )
                }
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 4)
        )
    }
}

// MARK: - Detail Item Small Component
struct DetailItemSmall: View {
    let icon: String
    let value: String
    
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 14))
                .foregroundColor(Color(red: 0.467, green: 0, blue: 1))
            
            Text(value)
                .font(.system(size: 13, weight: .medium))
                .foregroundColor(.black)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    HomeRideCompleteDriver()
}

