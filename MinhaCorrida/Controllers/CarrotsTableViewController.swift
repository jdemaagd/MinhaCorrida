//
//  CarrotsTableViewController.swift
//  MinhaCorrida
//
//  Created by Jon DeMaagd on 9/5/20.
//  Copyright © 2020 JON DEMAAGD. All rights reserved.
//

import CoreData
import UIKit

class CarrotsTableViewController: UIViewController {

    // MARK: - @IBOutlets

    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - CarrotsTableViewController Properties
    
    var dataController: DataController!
    var statusList: [CarrotStatus]!
    
    
    // MARK: - Lifecycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        getCarrotStatusList()
    }
    
    
    // MARK: - CarrotsTableViewController Functions
    
    private func getRuns() -> [Run] {
        let fetchRequest: NSFetchRequest<Run> = Run.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: #keyPath(Run.timestamp), ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            return try dataController.viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
    }
    
    private func getCarrotStatusList() {
        statusList = CarrotStatus.carrotsEarned(runs: getRuns())
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailsVC = segue.destination as? CarrotDetailsViewController {
            if let indexPath = tableView.indexPathForSelectedRow {
                detailsVC.status = statusList[indexPath.row]
            }
        }
    }
}
