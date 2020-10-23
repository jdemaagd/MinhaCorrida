//
//  RunDetailsViewController+Extensions.swift
//  MinhaCorrida
//
//  Created by Jon DeMaagd on 9/5/20.
//  Copyright © 2020 JON DEMAAGD. All rights reserved.
//

import MapKit

// MARK: - MKMapViewDelegate Functions

extension RunDetailsViewController: MKMapViewDelegate {
    
    /*
        Note: when MapKit wants to display an overlay,
        it asks its delegate for something to render that overlay,
        if overlay is an MKPolyine (collection of line segments),
        return MKPolylineRenderer
     */
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        guard let polyline = overlay as? MulticolorPolyline else {
            return MKOverlayRenderer(overlay: overlay)
        }
        
        let renderer = MKPolylineRenderer(polyline: polyline)
        renderer.strokeColor = polyline.color
        renderer.lineWidth = 3
      
        return renderer
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? CarrotAnnotation else { return nil }
        let reuseID = "checkpoint"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseID)
      
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseID)
            annotationView?.image = #imageLiteral(resourceName: "mapPin")
            annotationView?.canShowCallout = true
        }
        annotationView?.annotation = annotation
            
        let carrotImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        carrotImageView.image = UIImage(named: annotation.imageName)
        carrotImageView.contentMode = .scaleAspectFit
        annotationView?.leftCalloutAccessoryView = carrotImageView
            
        return annotationView
    }
}
