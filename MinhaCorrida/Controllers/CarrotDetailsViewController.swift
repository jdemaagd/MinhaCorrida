//
//  CarrotDetailsViewController.swift
//  MinhaCorrida
//
//  Created by Jon DeMaagd on 9/5/20.
//  Copyright © 2020 JON DEMAAGD. All rights reserved.
//

import UIKit

class CarrotDetailsViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var bestLabel: UILabel!
    @IBOutlet weak var carrotImageView: UIImageView!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var earnedLabel: UILabel!
    @IBOutlet weak var goldImageView: UIImageView!
    @IBOutlet weak var goldLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var silverImageView: UIImageView!
    @IBOutlet weak var silverLabel: UILabel!
    @IBOutlet weak var topStackView: UIStackView!
    
    
    // MARK: - CarrotDetailsViewController Properties
    
    var carrotRotation: CGAffineTransform!
    var earnedDistance: Measurement<UnitLength>!
    var earnedDuration: Int!
    var status: CarrotStatus!
    
    
    // MARK: - Lifecycle Functions
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        topStackView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        topStackView.isLayoutMarginsRelativeArrangement = true
        
        setupCarrots()
    }
    
    
    // MARK: - CarrotDetailsViewController Functions
    
    private func setupCarrots() {
        carrotRotation = CGAffineTransform(rotationAngle: .pi / 8)
          
        if let imageUrl = status?.carrot.imageUrl {
            carrotImageView.image = UIImage(named: imageUrl)
        } else {
            carrotImageView.image = UIImage(named: K.placeHolderImage)
        }
        
        setLabels()
        
        earnedDistance = Measurement(value: status.earned!.distance, unit: UnitLength.meters)
        earnedDuration = Int(status.earned!.duration)
    
        setSilver()
        setGold()
    }
    
    private func setGold() {
        if let gold = status.gold {
            goldImageView.transform = carrotRotation
            goldImageView.alpha = 1
            let goldDate = UnitsFormatter.date(gold.timestamp)
            goldLabel.text = "Earned on \(goldDate)"
        } else {
            goldImageView.alpha = 0
            let goldDistance = earnedDistance * CarrotStatus.goldMultiplier
            let pace = UnitsFormatter.pace(distance: goldDistance,
                                        seconds: earnedDuration,
                                        outputUnit: UnitSpeed.minutesPerMile)
            goldLabel.text = "Pace < \(pace) for gold!"
        }
    }
    
    private func setLabels() {
        nameLabel.text = status.carrot.name
        distanceLabel.text = UnitsFormatter.distance(Double(status.carrot.distance)!)
        let earnedDate = UnitsFormatter.date(status.earned?.timestamp)
        earnedLabel.text = "Reached on \(earnedDate)"
          
        let bestDistance = Measurement(value: status.best!.distance, unit: UnitLength.meters)
        let bestPace = UnitsFormatter.pace(distance: bestDistance,
                                            seconds: Int(status.best!.duration),
                                            outputUnit: UnitSpeed.minutesPerMile)
        let bestDate = UnitsFormatter.date(status.earned?.timestamp)
        bestLabel.text = "Best: \(bestPace), \(bestDate)"
    }
    
    private func setSilver() {
        if let silver = status.silver {
            silverImageView.transform = carrotRotation
            silverImageView.alpha = 1
            let silverDate = UnitsFormatter.date(silver.timestamp)
            silverLabel.text = "Earned on \(silverDate)"
        } else {
            silverImageView.alpha = 0
            let silverDistance = earnedDistance * CarrotStatus.silverMultiplier
            let pace = UnitsFormatter.pace(distance: silverDistance,
                                        seconds: earnedDuration,
                                        outputUnit: UnitSpeed.minutesPerMile)
            silverLabel.text = "Pace < \(pace) for silver!"
        }
    }
    
    
    // MARK: - IBActions
    
    @IBAction func infoButtonTapped() {
        let alert = UIAlertController(title: status.carrot.name,
                                    message: status.carrot.information,
                                    preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(alert, animated: true)
    }
}
