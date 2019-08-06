//
//  AlarmDetailTableViewController.swift
//  AlarmProject
//
//  Created by Blake kvarfordt on 8/5/19.
//  Copyright © 2019 Blake kvarfordt. All rights reserved.
//

import UIKit

class AlarmDetailTableViewController: UITableViewController {

    var alarmIsOn: Bool = true
    
    var alarm: Alarm? {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var textFieldLabel: UITextField!
    @IBOutlet weak var enableButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    private func updateViews() {
        loadViewIfNeeded()
        guard let alarm = alarm else { return }
        datePicker.date = alarm.fireDate
        textFieldLabel.text = alarm.name 
         
    }
    
    // MARK: - Actions
    @IBAction func enableButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let textFieldText = textFieldLabel.text else { return }
        if let alarm = alarm {
            AlarmController.shared.update(alarm: alarm, fireDate: datePicker.date, name: textFieldText, enabled: alarmIsOn)
        } else {
            AlarmController.shared.addAlarm(fireDate: datePicker.date, name: textFieldText, enabled: alarmIsOn)
        }
    }
    

}
