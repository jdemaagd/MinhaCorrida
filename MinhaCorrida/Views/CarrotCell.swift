//
//  CarrotCell.swift
//  MinhaCorrida
//
//  Created by Jon DeMaagd on 9/13/20.
//  Copyright © 2020 JON DEMAAGD. All rights reserved.
//

import UIKit

internal final class CarrotCell: UITableViewCell, Cell {

    // MARK: - IBOutlets
    
    @IBOutlet weak var carrotImageView: UIImageView!
    @IBOutlet weak var earnedLabel: UILabel!
    @IBOutlet weak var goldImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var silverImageView: UIImageView!
    
    
    // MARK: - CarrotCell Properties
    
    var status: CarrotStatus! {
        didSet {
            configure()
        }
    }
    
    private let carrotRotation = CGAffineTransform(rotationAngle: .pi / 8)
    private let greenLabel = #colorLiteral(red: 0, green: 0.5725490196, blue: 0.3058823529, alpha: 1)
    private let redLabel = #colorLiteral(red: 1, green: 0.07843137255, blue: 0.1725490196, alpha: 1)
    
    
    // MARK: - Lifecycle Functions
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    

    // MARK: - CarrotCell Functions
    
    private func configure() {
        silverImageView.isHidden = status.silver == nil
        goldImageView.isHidden = status.gold == nil
        if let earned = status.earned {
            nameLabel.text = status.carrot.name
            nameLabel.textColor = greenLabel
            let dateEarned = UnitsFormatter.date(earned.timestamp)
            earnedLabel.text = "Earned: \(dateEarned)"
            earnedLabel.textColor = greenLabel
            carrotImageView.image = UIImage(named: status.carrot.imageUrl)
            silverImageView.transform = carrotRotation
            goldImageView.transform = carrotRotation
            isUserInteractionEnabled = true
            accessoryType = .disclosureIndicator
        } else {
            nameLabel.text = "?????"
            nameLabel.textColor = redLabel
            let formattedDistance = UnitsFormatter.distance(Double(status.carrot.distance)!)
            earnedLabel.text = "Run \(formattedDistance) to earn"
            earnedLabel.textColor = redLabel
            carrotImageView.image = nil
            isUserInteractionEnabled = false
            accessoryType = .none
            selectionStyle = .none
        }
    }
}
