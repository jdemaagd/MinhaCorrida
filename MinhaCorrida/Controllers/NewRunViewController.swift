//
//  NewRunViewController.swift
//  MinhaCorrida
//
//  Created by Jon DeMaagd on 9/5/20.
//  Copyright © 2020 JON DEMAAGD. All rights reserved.
//

import AVFoundation
import CoreData
import CoreLocation
import MapKit
import MediaPlayer
import UIKit

class NewRunViewController: UIViewController {
  
    // MARK: - IBOutlets
    
    @IBOutlet weak var buttonStackView: UIStackView!
    @IBOutlet weak var carrotImageView: UIImageView!
    @IBOutlet weak var carrotInfoLabel: UILabel!
    @IBOutlet weak var carrotStackView: UIStackView!
    @IBOutlet weak var dataStackView: UIStackView!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var launchStackView: UIStackView!
    @IBOutlet weak var mapContainerView: UIView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var paceLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    

    // MARK: - NewRunViewController Properties
    
    var dataController: DataController!
    var defaults = UserDefaults.standard
    var distance = Measurement(value: 0, unit: UnitLength.meters)
    var locationList: [CLLocation] = []
    
    private let cheerSound: AVAudioPlayer = {
        guard let cheerSound = NSDataAsset(name: "cheer") else {
            return AVAudioPlayer()
        }
        return try! AVAudioPlayer(data: cheerSound.data)
    }()
    private let locationManager = LocationManager.shared
    private var run: Run?
    private var seconds = 0
    private var timer: Timer?
    private var upcomingCarrot: Carrot!
    

    // MARK: - Lifecycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        defaults.set(0.77, forKey: "Volume")
        
        startButton.layer.cornerRadius = 20.0
        stopButton.layer.cornerRadius = 20.0
        
        dataStackView.isHidden = true
        mapContainerView.isHidden = true
        stopButton.isHidden = true
        
        buttonStackView.layoutMargins = UIEdgeInsets(top: 24, left: 0, bottom: 0, right: 0)
        buttonStackView.isLayoutMarginsRelativeArrangement = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        timer?.invalidate()
        locationManager.stopUpdatingLocation()
    }
    
    
    // MARK: - NewRunViewController Functions
    
    private func checkNextCarrot() {
        let nextCarrot = Carrot.next(for: distance.value)
        if upcomingCarrot != nextCarrot {
            carrotImageView.image = UIImage(named: nextCarrot.imageUrl)
            upcomingCarrot = nextCarrot
            cheerSound.play()   // TODO: update audio!
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
        }
    }

    private func eachSecond() {
        seconds += 1
        checkNextCarrot()
        updateDisplay()
    }
    
    private func saveRun() {
        // Note: save run metrics to Core Data
        let newRun = Run(context: dataController.viewContext)
        newRun.distance = distance.value
        newRun.duration = Double(seconds)
        newRun.timestamp = Date()
      
        for location in locationList {
            // Note: save location data to Core Data
            let locationObject = Location(context: dataController.viewContext)
            locationObject.timestamp = location.timestamp
            locationObject.latitude = location.coordinate.latitude
            locationObject.longitude = location.coordinate.longitude
            newRun.addToLocations(locationObject)
        }
      
        try? dataController.viewContext.save()
      
        run = newRun
    }
    
    private func startLocationUpdates() {
        
        // Note: allow this view controller to be delegate of Core Location
        //       to be able to receive and process location updates
        locationManager.delegate = self
        locationManager.activityType = .fitness
        
        /*
            Note: higher distanceFilter could reduce zigging and zagging
            thus, give a more accurate line
            a filter thats too high will pixelate readings
         */
        locationManager.distanceFilter = 10
        locationManager.startUpdatingLocation()
    }
    
    private func startRun() {
        
        let volumeView = MPVolumeView()
        if let view = volumeView.subviews.first as? UISlider
        {
             view.value = defaults.float(forKey: "Volume")
        }
        
        carrotStackView.isHidden = false
        dataStackView.isHidden = false
        launchStackView.isHidden = true
        mapContainerView.isHidden = false
        startButton.isHidden = true
        stopButton.isHidden = false
        
        //mapView.removeOverlays(mapView.overlays)

        seconds = 0
        distance = Measurement(value: 0, unit: UnitLength.meters)
        locationList.removeAll()
        
        upcomingCarrot = Carrot.next(for: 0)
        carrotImageView.image = UIImage(named: upcomingCarrot.imageUrl)

        updateDisplay()
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.eachSecond()
        }
        
        startLocationUpdates()
    }
    
    private func stopRun() {
        carrotStackView.isHidden = true
        dataStackView.isHidden = true
        launchStackView.isHidden = false
        mapContainerView.isHidden = true
        startButton.isHidden = false
        stopButton.isHidden = true
        
        locationManager.stopUpdatingLocation()
    }
    
    private func updateDisplay() {
        let formattedDistance = UnitsFormatter.distance(distance)
        let formattedTime = UnitsFormatter.time(seconds)
        
        var localePace = UnitSpeed.minutesPerKilometer
        if let locale = Locale.current.regionCode, locale.caseInsensitiveCompare(K.localeUS) == .orderedSame {
            localePace = UnitSpeed.minutesPerMile
        }
        let formattedPace = UnitsFormatter.pace(distance: distance, seconds: seconds, outputUnit: localePace)
       
        distanceLabel.text = "Distance:  \(formattedDistance)"
        timeLabel.text = "Time:  \(formattedTime)"
        paceLabel.text = "Pace:  \(formattedPace)"
        
        let distanceRemaining = Double(upcomingCarrot.distance)! - distance.value
        let formattedDistanceRemaining = UnitsFormatter.distance(distanceRemaining)
        carrotInfoLabel.text = "\(formattedDistanceRemaining) until \(upcomingCarrot.name)"
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? RunDetailsViewController {
            vc.run = run
            vc.dataController = dataController
        }
    }

    
    // MARK: - IBActions
    
    @IBAction func startTapped() {
        startRun()
    }
    
    @IBAction func stopTapped() {
        
        // Note: present user with alerts on how to stop or not
        
        let alertController = UIAlertController(title: "End run?",
            message: "Do you wish to end your run?", preferredStyle: .actionSheet)
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        alertController.addAction(UIAlertAction(title: "Save", style: .default) { _ in
            self.stopRun()
            self.saveRun()
            self.performSegue(withIdentifier: K.runDetailsSegueIdentifier, sender: self)
        })

        alertController.addAction(UIAlertAction(title: "Discard", style: .destructive) { _ in
            self.stopRun()
            _ = self.navigationController?.popToRootViewController(animated: true)
        })
            
        present(alertController, animated: true)
    }
}
