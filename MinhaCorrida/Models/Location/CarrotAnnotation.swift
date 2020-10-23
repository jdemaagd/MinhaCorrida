//
//  CarrotAnnotation.swift
//  MinhaCorrida
//
//  Created by Jon DeMaagd on 9/20/20.
//  Copyright © 2020 JON DEMAAGD. All rights reserved.
//

import MapKit

class CarrotAnnotation: MKPointAnnotation {
    let imageName: String
  
    init(imageName: String) {
        self.imageName = imageName
        super.init()
    }
}
