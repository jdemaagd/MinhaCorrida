//
//  PastRunDetailsViewController.swift
//  MinhaCorrida
//
//  Created by Jon DeMaagd on 9/13/20.
//  Copyright © 2020 JON DEMAAGD. All rights reserved.
//

import CoreData
import UIKit

class PastRunDetailsViewController: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet weak var runMetricsLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - PastRunDetailsViewController Properties
    
    var run: Run!
    

    // MARK: - Lifecycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self

        formattedRunMetricsLabel()
    }
    
    
    // MARK: - PastRunDetailsViewController Functions
    
    private func formattedRunMetricsLabel() {
        let runDate = UnitsFormatter.date(run.timestamp)
        let distance = UnitsFormatter.distance(run.distance)
        let duration = UnitsFormatter.time(Int(run.duration))
        
        runMetricsLabel.text = "At: \(runDate)    Ran: \(distance)    For: \(duration) min(s)"
    }
}


// MARK: - UITableView Extension Functions

extension PastRunDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return run.locations?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.locationCellIdentifier, for: indexPath) as! LocationCell
        
        let location = run.locations?[indexPath.row] as! Location
        
        cell.locationLabel.text = "Lat\\Lon:  \(String(format: "%.2f", location.latitude))\\\(String(format: "%.2f", location.longitude))"
        cell.dateLabel.text = UnitsFormatter.date(run.timestamp)
        
        return cell
    }
}
