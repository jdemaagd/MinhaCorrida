//
//  PastRunCell.swift
//  MinhaCorrida
//
//  Created by Jon DeMaagd on 9/13/20.
//  Copyright © 2020 JON DEMAAGD. All rights reserved.
//

import UIKit

internal final class PastRunCell: UITableViewCell, Cell {

    // MARK: - IBOutlets
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!

    
    // MARK: - Lifecycle Functions
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        dateLabel.text = nil
        distanceLabel.text = nil
        durationLabel.text = nil
    }
}
