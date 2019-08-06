//
//  AlarmController.swift
//  AlarmProject
//
//  Created by Blake kvarfordt on 8/5/19.
//  Copyright © 2019 Blake kvarfordt. All rights reserved.
//

import Foundation

class AlarmController {
    
    static let shared = AlarmController()
    
    var alarms = [Alarm]()
    
//    init() {
//        let mockAlarms: [Alarm] = {
//            return [
//                Alarm(fireDate: Date(), name: "Class", enabled: false),
//                Alarm(fireDate: Date(), name: "Dinner", enabled: false),
//                Alarm(fireDate: Date(), name: "Bowling", enabled: false),
//                Alarm(fireDate: Date(), name: "TV Show", enabled: false)
//            ]
//        }()
//        alarms = mockAlarms
//    }
    
    func addAlarm(fireDate: Date, name: String, enabled: Bool) {
        let alarm = Alarm(fireDate: fireDate, name: name, enabled: enabled)
        alarms.append(alarm)
    }
    
    func update(alarm: Alarm, fireDate: Date, name: String, enabled: Bool) {
        alarm.fireDate = fireDate
        alarm.name = name
        alarm.enabled = enabled
    }
    
    func delete(alarm: Alarm) {
        guard let index = alarms.firstIndex(of: alarm) else { return }
        alarms.remove(at: index)
    }
    
    func toggleEnabled(for alarm: Alarm) {
        alarm.enabled.toggle()
    }
}
