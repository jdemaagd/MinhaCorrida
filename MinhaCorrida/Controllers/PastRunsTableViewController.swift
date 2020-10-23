//
//  PastRunsTableViewController.swift
//  MinhaCorrida
//
//  Created by Jon DeMaagd on 9/5/20.
//  Copyright © 2020 JON DEMAAGD. All rights reserved.
//

import CoreData
import UIKit

class PastRunsTableViewController: UITableViewController {
    
    // MARK: - PastRunsTableViewController Properties
    
    var dataController: DataController!
    var fetchedResultsController: NSFetchedResultsController<Run>!
    var onContentUpdated: (() -> Void)? = nil
    var runs: [Run] = []
    
    
    // MARK: - Lifecycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadRuns()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadRuns()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        fetchedResultsController = nil
    }
    
    
    // MARK: - PastRunsTableViewController Functions
    
    private func loadRuns() {
        let request: NSFetchRequest<Run> = Run.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "timestamp", ascending: false)
        request.sortDescriptors = [sortDescriptor]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: dataController.viewContext, sectionNameKeyPath: nil, cacheName: "runs")
        
        fetchedResultsController.delegate = self
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalError("Fetching runs could not be performed: \(error.localizedDescription)")
        }
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailsVC = segue.destination as? PastRunDetailsViewController {
            if let indexPath = tableView.indexPathForSelectedRow {
                detailsVC.run = fetchedResultsController.object(at: indexPath)
            }
        }
    }
}
