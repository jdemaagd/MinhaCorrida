//
//  SecretsManager.swift
//  MinhaCorrida
//
//  Created by Jon DeMaagd on 10/23/20.
//  Copyright © 2020 JON DEMAAGD. All rights reserved.
//

import Keys

public class SecretsManager {
    let keys = MinhaCorridaKeys()
    
    var appCenterAppSecret: String? {
        return keys.appCenterAppSecret
    }
    
    var azureMinhaCorridaBaseUrl: String? {
        return keys.azureMinhaCorridaBaseUrl
    }
    
    var azureMinhaCorridaFunctionKey: String? {
        return keys.azureMinhaCorridaFunctionKey
    }

    var jsonSecret: String? {
        if let path = Bundle.main.path(forResource: "Secrets", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? Dictionary<String, String>, let secret = jsonResult["secret"] {
                    return secret
                }
            } catch {
                print("Error reading JSON file: \(error)")
            }
        }

        return nil
    }
}
