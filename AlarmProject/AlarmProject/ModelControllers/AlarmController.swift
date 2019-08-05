//
//  AlarmController.swift
//  AlarmProject
//
//  Created by Blake kvarfordt on 8/5/19.
//  Copyright © 2019 Blake kvarfordt. All rights reserved.
//

import Foundation

class AlarmController {
    
    var alarms = [Alarm]()
    
    
    func addAlarm(fireDate: Date, name: String, enabled: Bool) {
        let alarm = Alarm(fireDate: fireDate, name: name, enabled: enabled, fireTime: <#T##String#>)
    }
}
