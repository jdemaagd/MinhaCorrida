//
//  SceneDelegate.swift
//  MinhaCorrida
//
//  Created by Jon DeMaagd on 8/29/20.
//  Copyright © 2020 JON DEMAAGD. All rights reserved.
//

import AppCenter
import AppCenterAnalytics
import AppCenterCrashes
import CoreData
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    let dataController = DataController(modelName: K.modelName)
    var rootViewController: UINavigationController?
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let _ = (scene as? UIWindowScene) else { return }

        MSAppCenter.start(SecretsManager().appCenterAppSecret, withServices:[
          MSAnalytics.self,
          MSCrashes.self
        ])
        
        dataController.load()
        
        rootViewController = window?.rootViewController as? UINavigationController
        let homeViewController = rootViewController?.topViewController as! HomeViewController
        homeViewController.dataController = dataController
        
        let locationManager = LocationManager.shared
        locationManager.requestWhenInUseAuthorization()
    }

    func sceneWillResignActive(_ scene: UIScene) {
        saveViewContext()
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        saveViewContext()
    }
    
    func saveViewContext() {
        try? dataController.viewContext.save()
    }
}
