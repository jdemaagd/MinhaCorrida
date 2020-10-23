//
//  CarrotsTableViewController+Extensions.swift
//  MinhaCorrida
//
//  Created by Jon DeMaagd on 9/20/20.
//  Copyright © 2020 JON DEMAAGD. All rights reserved.
//

import UIKit

// MARK: - CarrotsTableViewController DataSource Functions

extension CarrotsTableViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return statusList == nil ? 0 : statusList.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.carrotCellIdentifier, for: indexPath) as! CarrotCell
                
        cell.status = statusList[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: K.carrotDetailsSegueIdentifier, sender: self)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
