import SwiftUI
import MapKit

struct HomePassenger: View {
    @StateObject private var locationManager = LocationManager()
    @State private var mapPosition: MapCameraPosition = .userLocation(fallback: .automatic)
    @State private var searchText = ""
    @State private var showScheduleRide = false
    @State private var goToArrivalTime = false
    
    var body: some View {
        NavigationStack {
            NavigationLink(destination: HomeArrivalTime(), isActive: $goToArrivalTime) { EmptyView() }
            
            ZStack {
                // Map Background
                Map(position: $mapPosition, interactionModes: [.pan, .zoom, .rotate]) {
                    if let location = locationManager.userLocation {
                        Annotation("Me", coordinate: location.coordinate) {
                            VStack(spacing: 4) {
                                ZStack {
                                    Circle()
                                        .fill(Color.white)
                                        .frame(width: 32, height: 32)
                                        .shadow(color: .black.opacity(0.3), radius: 4)
                                    
                                    Circle()
                                        .fill(Color(red: 0.467, green: 0, blue: 1))
                                        .frame(width: 22, height: 22)
                                }
                                
                                Text("Me")
                                    .font(.system(size: 11, weight: .semibold))
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(
                                        Capsule()
                                            .fill(Color(red: 0.467, green: 0, blue: 1))
                                            .shadow(color: .black.opacity(0.2), radius: 2)
                                    )
                            }
                        }
                    }
                }
                .mapStyle(.standard)
                .mapControls {
                    MapUserLocationButton()
                    MapCompass()
                }
                .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 0) {
                    topBar
                    Spacer()
                    bottomSheet
                }
            }
        }
        .onAppear {
            locationManager.requestAuthorization()
        }
        .onChange(of: locationManager.userLocation) { newLocation in
            if let location = newLocation {
                updateMapPosition(for: location)
            }
        }
        .sheet(isPresented: $showScheduleRide) {
            ScheduleRideViewEnhanced(onScheduled: {
                showScheduleRide = false
                goToArrivalTime = true
            })
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
        .padding(.top, 8)
        .offset(y: -50)
    }
    
    // MARK: - Bottom Sheet
    private var bottomSheet: some View {
        VStack(spacing: 0) {
            RoundedRectangle(cornerRadius: 3)
                .fill(Color.gray.opacity(0.3))
                .frame(width: 40, height: 5)
                .padding(.top, 12)
            
            VStack(spacing: 24) {
                searchSection
                safetyNotice
                scheduleSection
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
    
    // MARK: - Search Section
    private var searchSection: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 16))
                .foregroundColor(.gray)
            
            TextField("Where to go?", text: $searchText)
                .font(.system(size: 16))
                .foregroundColor(.black)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(red: 0.96, green: 0.96, blue: 0.96))
        )
    }
    
    // MARK: - Safety Notice
    private var safetyNotice: some View {
        HStack(spacing: 10) {
            Image(systemName: "shield.checkered")
                .font(.system(size: 14))
                .foregroundColor(Color(red: 0.467, green: 0, blue: 1))
            
            Text("Driver may record audio for added safety")
                .font(.system(size: 13))
                .foregroundColor(.gray)
            
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(red: 0.467, green: 0, blue: 1).opacity(0.05))
        )
    }
    
    // MARK: - Schedule Section
    private var scheduleSection: some View {
        VStack(spacing: 16) {
            VStack(spacing: 8) {
                Text("Know where to in advance?")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.black)
                
                Text("Schedule your ride to cut the wait!")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
            }
            
            Button(action: {
                showScheduleRide = true
            }) {
                Text("Schedule Ride")
                    .font(.system(size: 16, weight: .semibold))
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
    
    // MARK: - Helper
    private func updateMapPosition(for location: CLLocation) {
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: location.coordinate, span: span)
        withAnimation(.easeInOut(duration: 0.3)) {
            mapPosition = .region(region)
        }
    }
}

// MARK: - Enhanced Schedule Ride View
struct ScheduleRideViewEnhanced: View {
    @Environment(\.dismiss) private var dismiss
    @State private var selectedDate = Date()
    @State private var pickupLocation = ""
    @State private var dropoffLocation = ""
    let onScheduled: (() -> Void)?
    
    init(onScheduled: (() -> Void)? = nil) {
        self.onScheduled = onScheduled
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    VStack(spacing: 20) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Pickup Location")
                                .font(.system(size: 13, weight: .medium))
                                .foregroundColor(.gray)
                            
                            HStack(spacing: 12) {
                                Image(systemName: "location.fill")
                                    .font(.system(size: 14))
                                    .foregroundColor(Color(red: 0.467, green: 0, blue: 1))
                                    .frame(width: 20)
                                
                                TextField("Enter pickup location", text: $pickupLocation)
                                    .foregroundColor(.black)
                            }
                            .padding()
                            .background(Color(red: 0.96, green: 0.96, blue: 0.96))
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(pickupLocation.isEmpty ? Color.clear : Color(red: 0.467, green: 0, blue: 1).opacity(0.3), lineWidth: 1)
                            )
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Destination")
                                .font(.system(size: 13, weight: .medium))
                                .foregroundColor(.gray)
                            
                            HStack(spacing: 12) {
                                Image(systemName: "mappin.circle.fill")
                                    .font(.system(size: 14))
                                    .foregroundColor(Color(red: 0.467, green: 0, blue: 1))
                                    .frame(width: 20)
                                
                                TextField("Where to?", text: $dropoffLocation)
                                    .foregroundColor(.black)
                            }
                            .padding()
                            .background(Color(red: 0.96, green: 0.96, blue: 0.96))
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(dropoffLocation.isEmpty ? Color.clear : Color(red: 0.467, green: 0, blue: 1).opacity(0.3), lineWidth: 1)
                            )
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Schedule For")
                                .font(.system(size: 13, weight: .medium))
                                .foregroundColor(.gray)
                            
                            DatePicker("", selection: $selectedDate, in: Date()...)
                                .datePickerStyle(.compact)
                                .labelsHidden()
                                .padding()
                                .background(Color(red: 0.96, green: 0.96, blue: 0.96))
                                .cornerRadius(8)
                        }
                    }
                    .padding(24)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.white)
                            .shadow(color: Color.black.opacity(0.08), radius: 12, x: 0, y: 4)
                    )
                    
                    Button(action: {
                        onScheduled?()
                        dismiss()
                    }) {
                        Text("Schedule Ride")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(isFormValid ? Color(red: 0.467, green: 0, blue: 1) : Color.gray.opacity(0.5))
                                    .shadow(color: isFormValid ? Color.black.opacity(0.25) : Color.clear, radius: 4, x: 0, y: 4)
                            )
                    }
                    .disabled(!isFormValid)
                }
                .padding(.horizontal, 24)
                .padding(.top, 20)
            }
            .background(Color(red: 0.98, green: 0.98, blue: 0.98))
            .navigationTitle("Schedule Ride")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundColor(Color(red: 0.467, green: 0, blue: 1))
                }
            }
        }
    }
    
    private var isFormValid: Bool {
        !pickupLocation.isEmpty && !dropoffLocation.isEmpty
    }
}

#Preview {
    HomePassenger()
}
