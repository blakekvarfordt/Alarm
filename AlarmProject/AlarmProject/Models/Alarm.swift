//
//  Alarm.swift
//  AlarmProject
//
//  Created by Blake kvarfordt on 8/5/19.
//  Copyright © 2019 Blake kvarfordt. All rights reserved.
//

import Foundation

class Alarm: Codable {
    
    var fireDate: Date
    var name: String
    var enabled: Bool
    var uuid: String
    var fireTime: String {
        get {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "h:mm a"
            return dateFormatter.string(from: fireDate)
        }
    }
    
    init(fireDate: Date, name: String, enabled: Bool) {
        self.fireDate = fireDate
        self.name = name
        self.enabled = enabled
        self.uuid = UUID().uuidString
    }
}

extension Alarm: Equatable {
    static func == (lhs: Alarm, rhs: Alarm) -> Bool {
       return lhs.uuid == rhs.uuid
    
    }
    
    
}
