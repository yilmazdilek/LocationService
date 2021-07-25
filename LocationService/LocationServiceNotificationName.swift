//
//  LocationServiceNotificationName.swift
//  LocationService
//
//  Created by Yilmaz Dilek on 26.07.21.
//

import Foundation

enum LocationServiceNotificationName {
    case authorizationStatusChanged
    case locationDidUpdate
}

extension LocationServiceNotificationName {
    var nameValue: Notification.Name {
        switch self {
        case .authorizationStatusChanged:
            return Notification.Name(rawValue: "LocationServiceNotification_authorizationStatusChanged")
        case .locationDidUpdate:
            return Notification.Name(rawValue: "LocationServiceNotification_locationDidUpdate")
        }
    }
}
