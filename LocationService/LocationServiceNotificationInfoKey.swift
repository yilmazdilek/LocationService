//
//  LocationServiceNotificationInfoKey.swift
//  LocationService
//
//  Created by Yilmaz Dilek on 26.07.21.
//

import Foundation

enum LocationServiceNotificationInfoKey {
    case authorizationStatus
    case location
}

extension LocationServiceNotificationInfoKey {
    var stringValue: String {
        switch self {
        case .authorizationStatus: return "LocationServiceNotificationInfoKey_authorizationStatus"
        case .location: return "LocationServiceNotificationInfoKey_location"
        }
    }
}
