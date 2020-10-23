//
//  CarrotStatus.swift
//  MinhaCorrida
//
//  Created by Jon DeMaagd on 9/19/20.
//  Copyright © 2020 JON DEMAAGD. All rights reserved.
//

import Foundation

struct CarrotStatus {
    let best: Run?
    let carrot: Carrot
    let earned: Run?
    let gold: Run?
    let silver: Run?
  
    static let goldMultiplier = 1.1
    static let silverMultiplier = 1.05
    
    static func carrotsEarned(runs: [Run]) -> [CarrotStatus] {
        return Carrot.allCarrots.map { carrot in
            var earned: Run?
            var silver: Run?
            var gold: Run?
            var best: Run?
        
            for run in runs where run.distance > Double(carrot.distance)! {
                if earned == nil {
                    earned = run
                }
          
                let earnedSpeed = earned!.distance / Double(earned!.duration)
                let runSpeed = run.distance / Double(run.duration)
          
                if silver == nil && runSpeed > earnedSpeed * silverMultiplier {
                    silver = run
                }
          
                if gold == nil && runSpeed > earnedSpeed * goldMultiplier {
                    gold = run
                }
          
                if let existingBest = best {
                    let bestSpeed = existingBest.distance / Double(existingBest.duration)
                    if runSpeed > bestSpeed {
                        best = run
                    }
                } else {
                    best = run
                }
            }
        
            return CarrotStatus(best: best, carrot: carrot, earned: earned, gold: gold, silver: silver)
        }
    }
}
