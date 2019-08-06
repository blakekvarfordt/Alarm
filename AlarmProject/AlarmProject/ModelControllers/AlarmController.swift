//
//  AlarmController.swift
//  AlarmProject
//
//  Created by Blake kvarfordt on 8/5/19.
//  Copyright © 2019 Blake kvarfordt. All rights reserved.
//

import Foundation
import UserNotifications


protocol AlarmScheduler: class {
    func scheduleUserNotifications(for alarm: Alarm)
    func cancelUserNotifications(for alarm: Alarm)
}

extension AlarmScheduler {
    func scheduleUserNotifications(for alarm: Alarm) {
        let content = UNMutableNotificationContent()
        content.title = "Alarm"
        content.body = "This is an alarm"
        content.sound = UNNotificationSound.default
        
        var dateComponents = Calendar.current.dateComponents([.hour, .minute], from: alarm.fireDate)
        dateComponents.second = 0
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: alarm.uuid, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("notification failed")
                print(error.localizedDescription)
                print(error)
            }
        }
        
    }
    
    func cancelUserNotifications(for alarm: Alarm) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [alarm.uuid])
        
    }
}

class AlarmController: Codable, AlarmScheduler {
    
    static let shared = AlarmController()
    
    var alarms = [Alarm]()
    
    func addAlarm(fireDate: Date, name: String, enabled: Bool) {
        let alarm = Alarm(fireDate: fireDate, name: name, enabled: enabled)
        alarms.append(alarm)
        saveToPersistence()
    }
    
    func update(alarm: Alarm, fireDate: Date, name: String, enabled: Bool) {
        alarm.fireDate = fireDate
        alarm.name = name
        alarm.enabled = enabled
        saveToPersistence()
    }
    
    func delete(alarm: Alarm) {
        guard let index = alarms.firstIndex(of: alarm) else { return }
        alarms.remove(at: index)
        saveToPersistence()
        cancelUserNotifications(for: alarm)
    }
    
    func toggleEnabled(for alarm: Alarm) {
        alarm.enabled.toggle()
        if !alarm.enabled {
            scheduleUserNotifications(for: alarm)
        } else {
            cancelUserNotifications(for: alarm)
        }
    }
    
    func fileURL() -> URL {
        let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileLocation = filePath[0]
        let file = fileLocation.appendingPathComponent("alarmFile.json")
        return file
    }
    
    private func saveToPersistence() {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(alarms)
            try data.write(to: fileURL())
        } catch {
            print("Error trying to encode data")
        }
    }
    
    func loadFromPersistence() {
        do {
            let data = try Data(contentsOf: fileURL())
            let decoder = JSONDecoder()
            let decodedAlarms = try decoder.decode([Alarm].self, from: data)
            alarms = decodedAlarms
        } catch {
            print("Error decoding alarms")
        }
    }
}


