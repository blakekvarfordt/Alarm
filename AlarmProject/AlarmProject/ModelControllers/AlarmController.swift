//
//  AlarmController.swift
//  AlarmProject
//
//  Created by Blake kvarfordt on 8/5/19.
//  Copyright © 2019 Blake kvarfordt. All rights reserved.
//

import Foundation

class AlarmController: Codable {
    
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
    }
    
    func toggleEnabled(for alarm: Alarm) {
        alarm.enabled.toggle()
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
