//
//  HomeViewController.swift
//  MinhaCorrida
//
//  Created by Jon DeMaagd on 8/29/20.
//  Copyright © 2020 JON DEMAAGD. All rights reserved.
//

import CoreData
import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var carrotButton: UIButton!
    @IBOutlet weak var buttonStackView: UIStackView!
    @IBOutlet weak var newRunButton: UIButton!
    @IBOutlet weak var pastRunsButton: UIButton!
    
    
    // MARK: - HomeViewController Properties
    
    var dataController: DataController!
    var carrots: [Carrot]!
    var currentCarrotsRequestTask: URLSessionTask?
    
    
    // MARK: - Lifecycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureButtons()
        
        // currentCarrotsRequestTask?.cancel()
        currentCarrotsRequestTask = CarrotAPI.requestCarrotsList(completion: handleCarrotsListResponse(carrots:error:))
    }
    
    
    // MARK: - HomeViewController Functions
    
    private func configureButtons() {      
        carrotButton.layer.cornerRadius = 20.0
        newRunButton.layer.cornerRadius = 20.0
        pastRunsButton.layer.cornerRadius = 20.0
        
        buttonStackView.layoutMargins = UIEdgeInsets(top: 24, left: 24, bottom: 24, right: 24)
        buttonStackView.isLayoutMarginsRelativeArrangement = true

        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    private func enableButtons() {
        carrotButton.isEnabled = true
        newRunButton.isEnabled = true
        pastRunsButton.isEnabled = true
        
        carrotButton.alpha = 1.0
        newRunButton.alpha = 1.0
        pastRunsButton.alpha = 1.0
    }
    
    private func handleCarrotsListResponse(carrots: [Carrot], error: Error?) {
        // TODO: if no carrots, load some fake data
        //       if network error alert and go back home (try again later)
        
        guard carrots.count > 0 else { return }
        
        Carrot.allCarrots = carrots
        Carrot.allCarrots.sort {
            Int($0.carrotId)! < Int($1.carrotId)!
        }
        
        self.activityIndicator.stopAnimating()
        self.enableButtons()
    }
    

    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let carrotVC = segue.destination as? CarrotsTableViewController {
            carrotVC.dataController = dataController
        }
        
        if let newRunVC = segue.destination as? NewRunViewController {
            newRunVC.dataController = dataController
        }
        
        if let pastRunsVC = segue.destination as? PastRunsTableViewController {
            pastRunsVC.dataController = dataController
        }
    }
    
    
    // MARK: - IBActions
    
    @IBAction func carrotTapped(_ sender: UIButton) {
        performSegue(withIdentifier: K.carrotsSegueIdentifier, sender: self)
    }
    
    @IBAction func pastRunsTapped(_ sender: UIButton) {
        performSegue(withIdentifier: K.pastRunsSegueIdentifier, sender: self)
    }
    
    @IBAction func newRunTapped(_ sender: UIButton) {
        performSegue(withIdentifier: K.newRunSegueIdentifier, sender: self)
    }
}
