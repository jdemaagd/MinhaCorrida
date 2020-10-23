//
//  LocationCell.swift
//  MinhaCorrida
//
//  Created by Jon DeMaagd on 9/20/20.
//  Copyright © 2020 JON DEMAAGD. All rights reserved.
//

import UIKit

internal final class LocationCell: UITableViewCell, Cell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!

    override func prepareForReuse() {
        super.prepareForReuse()
        
        dateLabel.text = nil
        locationLabel.text = nil
    }
}
