//
//  LocationService.swift
//  LocationService
//
//  Created by Yilmaz Dilek on 26.07.21.
//

import Foundation
import CoreLocation

final class LocationService: NSObject {
    private let locationManager: CLLocationManager
    
    init(locationMonitoringFilter: Double) {
        self.locationManager = CLLocationManager()
        super.init()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.distanceFilter = locationMonitoringFilter
        
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.showsBackgroundLocationIndicator = true
        locationManager.startUpdatingLocation()
    }
}

extension LocationService: LocationServiceInterface {
    
    func requestLocationAccessIfAvailable(withType type: LocationAccessType) -> Bool {
        switch type {
        case .always: locationManager.requestAlwaysAuthorization()
        case .whenInUse: locationManager.requestWhenInUseAuthorization()
        case .unavailable: return false
        }
        return true
    }
    
    func startMonitoringLocationUpdates() {
        locationManager.startUpdatingLocation()
    }
    
    func stopMonitoringLocationUpdates() {
        locationManager.stopUpdatingLocation()
    }
    
    func distance(from: Location, to: Location) -> Double {
        let fromLocation = CLLocation(latitude: from.lat, longitude: from.lon)
        let toLocation = CLLocation(latitude: to.lat, longitude: to.lon)
        
        return toLocation.distance(from: fromLocation)
    }
}

extension LocationService: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        switch locationManager.authorizationStatus {
        case .authorizedAlways: fallthrough
        case .authorizedWhenInUse:
            NotificationCenter.default.post(Notification(name: LocationServiceNotificationName.authorizationStatusChanged.nameValue,
                                                         object: self,
                                                         userInfo: [LocationServiceNotificationInfoKey.authorizationStatus: LocationAccessType.always]))
        case .notDetermined: break
        case .restricted: fallthrough
        case .denied: fallthrough
        @unknown default:
            NotificationCenter.default.post(Notification(name: LocationServiceNotificationName.authorizationStatusChanged.nameValue,
                                                         object: self,
                                                         userInfo: [LocationServiceNotificationInfoKey.authorizationStatus: LocationAccessType.unavailable]))
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let coordinate = locations.last?.coordinate else { return }
        
        NotificationCenter.default.post(Notification(name: LocationServiceNotificationName.locationDidUpdate.nameValue,
                                                     object: self,
                                                     userInfo: [LocationServiceNotificationInfoKey.location:
                                                        Location(lat: coordinate.latitude, lon: coordinate.longitude)]))
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // TODO: publish a notification
    }
}
