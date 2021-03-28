//
//  RandomUser+String.swift
//  RandomUser
//
//  Created by Daniel Esteban Salinas on 27/03/21.
//

import Foundation

extension String {
    /// Returns total seconds form a "HH:mm:ss" formatted string
    func secondsFromString() -> Int {
        var components: Array = self.components(separatedBy: ":").reversed()
        var result: Int = 0
        
        if let hoursStr = components.popLast(), let hours = Int(hoursStr) {
            result += hours * 60 * 60
        }
        
        if let minutesStr = components.popLast(), let minutes = Int(minutesStr) {
            result += minutes * 60
        }
        
        if let secondsStr = components.popLast(), let seconds = Int(secondsStr) {
            result += seconds
        }
        
        return result
    }
}
