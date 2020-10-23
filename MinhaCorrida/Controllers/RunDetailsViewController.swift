//
//  RunDetailsViewController.swift
//  MinhaCorrida
//
//  Created by Jon DeMaagd on 9/5/20.
//  Copyright © 2020 JON DEMAAGD. All rights reserved.
//

import MapKit
import UIKit

class RunDetailsViewController: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet weak var carrotImageView: UIImageView!
    @IBOutlet weak var carrotInfoButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var paceLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var timeLabel: UILabel!
    
    
    // MARK: - RunDetailsViewController Properties
    
    var dataController: DataController!
    var run: Run!
    
    
    // MARK: - Lifecycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stackView.layoutMargins = UIEdgeInsets(top: 8, left: 24, bottom: 16, right: 24)
        stackView.isLayoutMarginsRelativeArrangement = true

        configureView()
    }
    
    
    // MARK: - RunDetailsViewController Functions
    
    private func annotations() -> [CarrotAnnotation] {
        var annotations: [CarrotAnnotation] = []
        let carrotsEarned = Carrot.allCarrots.filter { Double($0.distance)! < run.distance }
        var carrotIterator = carrotsEarned.makeIterator()
        var nextCarrot = carrotIterator.next()
        let locations = run.locations?.array as! [Location]
        var distance = 0.0
      
        for (first, second) in zip(locations, locations.dropFirst()) {
            guard let carrot = nextCarrot else { break }
            let start = CLLocation(latitude: first.latitude, longitude: first.longitude)
            let end = CLLocation(latitude: second.latitude, longitude: second.longitude)
            distance += end.distance(from: start)
            if distance >= Double(carrot.distance)! {
                let carrotAnnotation = CarrotAnnotation(imageName: carrot.imageUrl)
                carrotAnnotation.coordinate = end.coordinate
                carrotAnnotation.title = carrot.name
                carrotAnnotation.subtitle = UnitsFormatter.distance(Double(carrot.distance)!)
                annotations.append(carrotAnnotation)
                nextCarrot = carrotIterator.next()
            }
        }
      
        return annotations
    }

    private func configureView() {
        
        let distance = Measurement(value: run.distance, unit: UnitLength.meters)
        let seconds = Int(run.duration)
        let formattedDistance = UnitsFormatter.distance(distance)
        let formattedDate = UnitsFormatter.date(run.timestamp)
        let formattedTime = UnitsFormatter.time(seconds)
        
        var localePace = UnitSpeed.minutesPerKilometer
        if let locale = Locale.current.regionCode, locale.caseInsensitiveCompare(K.localeUS) == .orderedSame {
            localePace = UnitSpeed.minutesPerMile
        }
        let formattedPace = UnitsFormatter.pace(distance: distance, seconds: seconds, outputUnit: localePace)
      
        distanceLabel.text = "Distance:  \(formattedDistance)"
        dateLabel.text = formattedDate
        timeLabel.text = "Time:  \(formattedTime)"
        paceLabel.text = "Pace:  \(formattedPace)"
        
        loadMap()
        
        let carrot = Carrot.best(for: run.distance)
        carrotImageView.image = UIImage(named: carrot.imageUrl)
    }
    
    // Note: is there something to draw? then set map region and add overlay
    private func loadMap() {
        guard
            let locations = run.locations, locations.count > 0, let region = mapRegion()
            else {
                let alert = UIAlertController(title: "Error",
                    message: "Sorry, this run has no locations saved",
                    preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                present(alert, animated: true)
          
                return
            }
        
        mapView.setRegion(region, animated: true)
        mapView.addOverlays(polyLine())
        
        mapView.addAnnotations(annotations())
    }
    
    // Note: display region for map, define by supplying center point
    //       and span that defines horizontal/vertical ranges
    private func mapRegion() -> MKCoordinateRegion? {
        guard
            let locations = run.locations, locations.count > 0
            else { return nil }
        
        let latitudes = locations.map { location -> Double in
            let location = location as! Location
            return location.latitude
        }
        
        let longitudes = locations.map { location -> Double in
            let location = location as! Location
            return location.longitude
        }
        
        let maxLat = latitudes.max()!
        let minLat = latitudes.min()!
        let maxLong = longitudes.max()!
        let minLong = longitudes.min()!
        
        let center = CLLocationCoordinate2D(latitude: (minLat + maxLat) / 2,
                                          longitude: (minLong + maxLong) / 2)
        let span = MKCoordinateSpan(latitudeDelta: (maxLat - minLat) * 1.3,
                                  longitudeDelta: (maxLong - minLong) * 1.3)
      
        return MKCoordinateRegion(center: center, span: span)
    }
    
    // Note: create overlay, turn each recorded location from run
    //       into a CLLocationCoordinate2D as required by MKPolyline
    private func polyLine() -> [MulticolorPolyline] {

        let locations = run.locations?.array as! [Location]
        var coordinates: [(CLLocation, CLLocation)] = []
        var speeds: [Double] = []
        var minSpeed = Double.greatestFiniteMagnitude
        var maxSpeed = 0.0

        for (first, second) in zip(locations, locations.dropFirst()) {
            let start = CLLocation(latitude: first.latitude, longitude: first.longitude)
            let end = CLLocation(latitude: second.latitude, longitude: second.longitude)
            coordinates.append((start, end))

            let distance = end.distance(from: start)
            let time = second.timestamp!.timeIntervalSince(first.timestamp! as Date)
            let speed = time > 0 ? distance / time : 0
            speeds.append(speed)
            minSpeed = min(minSpeed, speed)
            maxSpeed = max(maxSpeed, speed)
        }

        let midSpeed = speeds.reduce(0, +) / Double(speeds.count)

        var segments: [MulticolorPolyline] = []
        for ((start, end), speed) in zip(coordinates, speeds) {
            let coords = [start.coordinate, end.coordinate]
            let segment = MulticolorPolyline(coordinates: coords, count: 2)
            segment.color = segmentColor(speed: speed,
                                     midSpeed: midSpeed,
                                     slowestSpeed: minSpeed,
                                     fastestSpeed: maxSpeed)
            segments.append(segment)
        }
      
        return segments
    }
    
    private func segmentColor(speed: Double, midSpeed: Double, slowestSpeed: Double, fastestSpeed: Double) -> UIColor {
      
        enum BaseColors {
            static let r_red: CGFloat = 1
            static let r_green: CGFloat = 20 / 255
            static let r_blue: CGFloat = 44 / 255
            
            static let y_red: CGFloat = 1
            static let y_green: CGFloat = 215 / 255
            static let y_blue: CGFloat = 0
            
            static let g_red: CGFloat = 0
            static let g_green: CGFloat = 146 / 255
            static let g_blue: CGFloat = 78 / 255
        }
      
        let red, green, blue: CGFloat
      
        if speed < midSpeed {
            let ratio = CGFloat((speed - slowestSpeed) / (midSpeed - slowestSpeed))
            red = BaseColors.r_red + ratio * (BaseColors.y_red - BaseColors.r_red)
            green = BaseColors.r_green + ratio * (BaseColors.y_green - BaseColors.r_green)
            blue = BaseColors.r_blue + ratio * (BaseColors.y_blue - BaseColors.r_blue)
        } else {
            let ratio = CGFloat((speed - midSpeed) / (fastestSpeed - midSpeed))
            red = BaseColors.y_red + ratio * (BaseColors.g_red - BaseColors.y_red)
            green = BaseColors.y_green + ratio * (BaseColors.g_green - BaseColors.y_green)
            blue = BaseColors.y_blue + ratio * (BaseColors.g_blue - BaseColors.y_blue)
        }
      
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
    
    
    // MARK: - IBActions
    
    @IBAction func displayModeToggled(_ sender: UISwitch) {
        UIView.animate(withDuration: 0.2) {
            self.carrotImageView.alpha = sender.isOn ? 1 : 0
            self.carrotInfoButton.alpha = sender.isOn ? 1 : 0
            self.mapView.alpha = sender.isOn ? 0 : 1
        }
    }
    
    @IBAction func infoButtonTapped() {
        let carrot = Carrot.best(for: run.distance)
        let alert = UIAlertController(title: carrot.name,
                                    message: carrot.information,
                                    preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(alert, animated: true)
    }
}
