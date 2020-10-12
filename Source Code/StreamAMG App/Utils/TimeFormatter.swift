//
//  TimeFormatter.swift
//  StreamAMG App
//
//  Created by Rafal Ozog on 12/10/2020.
//

import Foundation

class TimeFormatter {
    
    func formatTimeToDisplay(timeInSeconds: Int?) -> String {
        if let timeInSeconds = timeInSeconds {
            let hours = Int(timeInSeconds) / 3600
            let minutes = Int(timeInSeconds) / 60 % 60
            let seconds = Int(timeInSeconds) % 60
            return String(format:"%01i:%02i:%02i", hours, minutes, seconds)
        }
        else {
           return "0:00:00"
        }
    }
}
