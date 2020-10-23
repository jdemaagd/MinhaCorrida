//
//  NewRunViewController+Extensions.swift
//  MinhaCorrida
//
//  Created by Jon DeMaagd on 9/6/20.
//  Copyright © 2020 JON DEMAAGD. All rights reserved.
//

import CoreLocation
import MapKit

extension NewRunViewController: CLLocationManagerDelegate, MKMapViewDelegate {

    // MARK: - CLLocationManagerDelegate Functions
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location Service Error: \(error.localizedDescription)")
    }
    
    // Note: update current run
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        for newLocation in locations {
            let howRecent = newLocation.timestamp.timeIntervalSinceNow
            guard newLocation.horizontalAccuracy < 20 && abs(howRecent) < 10 else { continue }

            if let lastLocation = locationList.last {
                let delta = newLocation.distance(from: lastLocation)
                
                distance = distance + Measurement(value: delta, unit: UnitLength.meters)
                
                let coordinates = [lastLocation.coordinate, newLocation.coordinate]
                mapView.addOverlay(MKPolyline(coordinates: coordinates, count: 2))

                let region = MKCoordinateRegion(center: newLocation.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
                mapView.setRegion(region, animated: true)
            }

            locationList.append(newLocation)
        }
    }
    
    
    // MARK: - MKMapViewDelegate Functions
    
    // Note: blue polyline trail for current run
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        guard let polyline = overlay as? MKPolyline else {
            return MKOverlayRenderer(overlay: overlay)
        }
      
        let renderer = MKPolylineRenderer(polyline: polyline)
        renderer.strokeColor = .blue
        renderer.lineWidth = 3
      
        return renderer
    }
}
