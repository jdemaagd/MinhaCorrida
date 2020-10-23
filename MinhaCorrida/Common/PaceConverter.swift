//
//  PaceConverter.swift
//  MinhaCorrida
//
//  Created by Jon DeMaagd on 9/5/20.
//  Copyright © 2020 JON DEMAAGD. All rights reserved.
//

import Foundation

class PaceConverter: UnitConverter {
    
    private let coefficient: Double
  
    init(coefficient: Double) {
        self.coefficient = coefficient
    }
  
    override func baseUnitValue(fromValue value: Double) -> Double {
        return reciprocal(value * coefficient)
    }
  
    override func value(fromBaseUnitValue baseUnitValue: Double) -> Double {
        return reciprocal(baseUnitValue * coefficient)
    }
  
    private func reciprocal(_ value: Double) -> Double {
        guard value != 0 else { return 0 }
        return 1.0 / value
    }
}

/*
    Pace: runners think of their progress in terms of time per unit distance,
          which is the inverse of speed (distance per unit time).
    UnitSpeed extension to support pace
 */
extension UnitSpeed {
    
    class var secondsPerMeter: UnitSpeed {
        return UnitSpeed(symbol: "sec/m", converter: PaceConverter(coefficient: 1))
    }
  
    class var minutesPerKilometer: UnitSpeed {
        return UnitSpeed(symbol: "min/km", converter: PaceConverter(coefficient: 60.0 / 1000.0))
    }
  
    class var minutesPerMile: UnitSpeed {
        return UnitSpeed(symbol: "min/mi", converter: PaceConverter(coefficient: 60.0 / 1609.34))
    }
}
