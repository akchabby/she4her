import Combine
import CoreLocation
import MapKit
import SwiftUI

// MARK: - Enhanced Location Manager
final class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    // MARK: - Properties
    private let manager = CLLocationManager()
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Published Properties
    @Published var authorizationStatus: CLAuthorizationStatus
    @Published var userLocation: CLLocation?
    @Published var heading: CLHeading?
    @Published var locationError: Error?
    
    // Distance and Route Tracking
    @Published var distanceToDestination: CLLocationDistance?
    @Published var estimatedTimeOfArrival: Date?
    @Published var currentRoute: MKRoute?
    
    // Location Updates
    @Published var isUpdatingLocation = false
    @Published var locationAccuracy: CLLocationAccuracy = kCLLocationAccuracyBest
    
    // MARK: - Initialization
    override init() {
        self.authorizationStatus = manager.authorizationStatus
        super.init()
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.distanceFilter = 10 // Update every 10 meters
        manager.allowsBackgroundLocationUpdates = true
        manager.pausesLocationUpdatesAutomatically = false
        manager.showsBackgroundLocationIndicator = true
    }
    
    // MARK: - Public Methods
    
    /// Request location authorization and start tracking
    func requestAuthorization() {
        switch manager.authorizationStatus {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse:
            manager.requestAlwaysAuthorization() // For drivers who need background tracking
        case .authorizedAlways, .authorizedWhenInUse:
            startTracking()
        default:
            break
        }
    }
    
    /// Start location tracking
    func startTracking() {
        manager.startUpdatingLocation()
        manager.startUpdatingHeading()
        isUpdatingLocation = true
    }
    
    /// Stop location tracking
    func stopTracking() {
        manager.stopUpdatingLocation()
        manager.stopUpdatingHeading()
        isUpdatingLocation = false
    }
    
    /// Calculate route between two points
    func calculateRoute(from source: CLLocationCoordinate2D,
                       to destination: CLLocationCoordinate2D,
                       completion: @escaping (MKRoute?) -> Void) {
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: source))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destination))
        request.transportType = .automobile
        request.requestsAlternateRoutes = false
        
        let directions = MKDirections(request: request)
        directions.calculate { [weak self] response, error in
            guard let self = self else { return }
            
            if let error = error {
                print("❌ Route calculation error: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self.locationError = error
                    completion(nil)
                }
                return
            }
            
            guard let route = response?.routes.first else {
                print("❌ No routes found")
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            
            DispatchQueue.main.async {
                self.currentRoute = route
                self.distanceToDestination = route.distance
                self.estimatedTimeOfArrival = Date().addingTimeInterval(route.expectedTravelTime)
                print("✅ Route calculated: \(route.distance)m, ETA: \(route.expectedTravelTime)s")
                completion(route)
            }
        }
    }
    
    /// Calculate distance between two coordinates
    func distance(from: CLLocationCoordinate2D, to: CLLocationCoordinate2D) -> CLLocationDistance {
        let fromLocation = CLLocation(latitude: from.latitude, longitude: from.longitude)
        let toLocation = CLLocation(latitude: to.latitude, longitude: to.longitude)
        return fromLocation.distance(from: toLocation)
    }
    
    /// Format distance for display
    func formatDistance(_ distance: CLLocationDistance) -> String {
        let distanceInMiles = distance * 0.000621371 // Convert meters to miles
        
        if distanceInMiles < 0.1 {
            return String(format: "%.0f ft", distance * 3.28084)
        } else if distanceInMiles < 10 {
            return String(format: "%.1f mi", distanceInMiles)
        } else {
            return String(format: "%.0f mi", distanceInMiles)
        }
    }
    
    /// Format time for display
    func formatTime(_ seconds: TimeInterval) -> String {
        let minutes = Int(seconds / 60)
        
        if minutes < 60 {
            return "\(minutes) min"
        } else {
            let hours = minutes / 60
            let remainingMinutes = minutes % 60
            if remainingMinutes > 0 {
                return "\(hours)h \(remainingMinutes)m"
            } else {
                return "\(hours)h"
            }
        }
    }
    
    /// Get formatted ETA string
    func formattedETA() -> String? {
        guard let eta = estimatedTimeOfArrival else { return nil }
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: eta)
    }
    
    /// Check if location services are enabled
    var isLocationServicesEnabled: Bool {
        return CLLocationManager.locationServicesEnabled()
    }
    
    /// Check if we have location permission
    var hasLocationPermission: Bool {
        switch authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            return true
        default:
            return false
        }
    }
    
    // MARK: - CLLocationManagerDelegate
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        DispatchQueue.main.async {
            self.authorizationStatus = manager.authorizationStatus
            
            switch manager.authorizationStatus {
            case .authorizedAlways, .authorizedWhenInUse:
                print("✅ Location authorized")
                self.startTracking()
            case .denied, .restricted:
                print("❌ Location access denied/restricted")
                self.stopTracking()
            case .notDetermined:
                print("⏳ Location authorization not determined")
            @unknown default:
                break
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let latestLocation = locations.last else { return }
        
        // Filter out stale or inaccurate locations
        let age = abs(latestLocation.timestamp.timeIntervalSinceNow)
        guard age < 10 && latestLocation.horizontalAccuracy >= 0 && latestLocation.horizontalAccuracy <= 100 else {
            return
        }
        
        DispatchQueue.main.async {
            self.userLocation = latestLocation
            print("📍 Location updated: \(latestLocation.coordinate.latitude), \(latestLocation.coordinate.longitude)")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        guard newHeading.headingAccuracy >= 0 else { return }
        
        DispatchQueue.main.async {
            self.heading = newHeading
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        DispatchQueue.main.async {
            self.locationError = error
            print("❌ Location error: \(error.localizedDescription)")
        }
    }
}

// MARK: - Location Helper Extensions

extension CLLocationCoordinate2D: Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}

extension CLLocationCoordinate2D {
    /// Check if coordinate is valid
    var isValid: Bool {
        return latitude >= -90 && latitude <= 90 && longitude >= -180 && longitude <= 180
    }
    
    /// Sample coordinates for testing
    static let applePark = CLLocationCoordinate2D(latitude: 37.3349, longitude: -122.0090)
    static let sanFrancisco = CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194)
    static let newYork = CLLocationCoordinate2D(latitude: 40.7128, longitude: -74.0060)
}

// MARK: - Map Camera Helper

extension LocationManager {
    /// Create a map camera position centered on user location
    func userCameraPosition(span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)) -> MapCameraPosition {
        guard let location = userLocation else {
            return .automatic
        }
        
        let region = MKCoordinateRegion(center: location.coordinate, span: span)
        return .region(region)
    }
    
    /// Create a map camera position showing both source and destination
    func routeCameraPosition(from source: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D, padding: CGFloat = 50) -> MapCameraPosition {
        let centerLat = (source.latitude + destination.latitude) / 2
        let centerLon = (source.longitude + destination.longitude) / 2
        let center = CLLocationCoordinate2D(latitude: centerLat, longitude: centerLon)
        
        let latDelta = abs(source.latitude - destination.latitude) * 1.5
        let lonDelta = abs(source.longitude - destination.longitude) * 1.5
        
        let span = MKCoordinateSpan(
            latitudeDelta: max(latDelta, 0.01),
            longitudeDelta: max(lonDelta, 0.01)
        )
        
        let region = MKCoordinateRegion(center: center, span: span)
        return .region(region)
    }
}

// MARK: - Preview Helper

#if DEBUG
extension LocationManager {
    /// Create a mock location manager for previews
    static var mock: LocationManager {
        let manager = LocationManager()
        manager.userLocation = CLLocation(
            latitude: CLLocationCoordinate2D.applePark.latitude,
            longitude: CLLocationCoordinate2D.applePark.longitude
        )
        return manager
    }
}
#endif
