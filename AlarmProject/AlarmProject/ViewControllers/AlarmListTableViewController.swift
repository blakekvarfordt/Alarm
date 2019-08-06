//
//  AlarmListTableViewController.swift
//  AlarmProject
//
//  Created by Blake kvarfordt on 8/5/19.
//  Copyright © 2019 Blake kvarfordt. All rights reserved.
//

import UIKit

class AlarmListTableViewController: UITableViewController {
    
    
    var alarm: Alarm?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AlarmController.shared.loadFromPersistence()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return AlarmController.shared.alarms.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? SwitchTableViewCell else { return UITableViewCell()}
        
        cell.delegate = self
        
        
        let alarm = AlarmController.shared.alarms[indexPath.row]
        
        cell.alarm = alarm
        
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alarm = AlarmController.shared.alarms[indexPath.row]
            AlarmController.shared.delete(alarm: alarm)
            tableView.reloadRows(at: [indexPath], with: .automatic)
            
        }
    }
    
        // MARK: - Navigation
        
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "ToAlarmDetailView" {
                if let destination = segue.destination as? AlarmDetailTableViewController {
                    if let indexPath = tableView.indexPathForSelectedRow {
                        let alarm = AlarmController.shared.alarms[indexPath.row]
                        destination.alarm = alarm
                    }
                }
            }
    }
}

extension AlarmListTableViewController: SwitchTableViewCellDelegate {
    func switchCellSwitchValueChanged(cell: SwitchTableViewCell) {
        guard let alarm = cell.alarm, let indexPath = tableView.indexPath(for: cell) else { return }
        
        AlarmController.shared.toggleEnabled(for: alarm)
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}

