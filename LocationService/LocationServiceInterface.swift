//
//  LocationServiceInterface.swift
//  LocationService
//
//  Created by Yilmaz Dilek on 26.07.21.
//

import Foundation

protocol LocationServiceInterface: AnyObject {
    func requestLocationAccessIfAvailable(withType type: LocationAccessType) -> Bool
    func startMonitoringLocationUpdates()
    func stopMonitoringLocationUpdates()
    func distance(from: Location, to: Location) -> Double
}
