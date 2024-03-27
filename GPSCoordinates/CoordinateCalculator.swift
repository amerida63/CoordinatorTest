//
//  CoordinateCalculator.swift
//  GPSCoordinates
//
//  Created by Anthony merida on 27/3/24.
//

import Foundation
import CoreLocation

class CoordinateCalculator {

    let earthRadius = 6371.0

    let lat1: CLLocationDegrees
    let lon1: CLLocationDegrees
    let lat2: CLLocationDegrees
    let lon2: CLLocationDegrees

    init(lat1: CLLocationDegrees, lon1: CLLocationDegrees, lat2: CLLocationDegrees, lon2: CLLocationDegrees) {
        self.lat1 = lat1
        self.lon1 = lon1
        self.lat2 = lat2
        self.lon2 = lon2
    }

    private func degreesToRadians(_ degrees: Double) -> Double {
        return degrees * Double.pi / 180.0
    }


    func distanceApple() -> String {

        let location1 = CLLocation(latitude: lat1, longitude: lon1)
        let location2 = CLLocation(latitude: lat2, longitude: lon2)

        let distanceInMeters = location1.distance(from: location2)
        let distanceInKm = distanceInMeters / 1000
        return String(format: "%.4f km", distanceInKm)
    }
    
    func distanceUsingHaversine() -> String {

        let lat1Rad = degreesToRadians(lat1)
        let lon1Rad = degreesToRadians(lon1)
        let lat2Rad = degreesToRadians(lat2)
        let lon2Rad = degreesToRadians(lon2)

        let deltaLon = lon2Rad - lon1Rad
        let deltaLat = lat2Rad - lat1Rad

        let a = pow(sin(deltaLat / 2), 2) + cos(lat1Rad) * cos(lat2Rad) * pow(sin(deltaLon / 2), 2)
        let c = 2 * atan2(sqrt(a), sqrt(1 - a))
        let distance = earthRadius * c

        return String(format: "%.4f km", distance)


    }

    func distanceUsingCoseno() -> String {

        let lat1Rad = degreesToRadians(lat1)
        let lon1Rad = degreesToRadians(lon1)
        let lat2Rad = degreesToRadians(lat2)
        let lon2Rad = degreesToRadians(lon2)

        let deltaLon = lon2Rad - lon1Rad
        let deltaLat = lat2Rad - lat1Rad

        let centralAngle = acos(sin(lat1Rad) * sin(lat2Rad) + cos(lat1Rad) * cos(lat2Rad) * cos(deltaLon))
        let distance = earthRadius * centralAngle

        return String(format: "%.4f km", distance)
    }
}
