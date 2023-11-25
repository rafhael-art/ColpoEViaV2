//
//  Date.swift
//  MessengerClone
//
//  Created by Rafhael Pillaca Pariona on 22/11/23.
//

import Foundation

extension Date {
    private var timeFormatter : DateFormatter{
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateFormat = "HH:mm"
        return formatter
    }
    
    private var dayFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        formatter.dateFormat = "dd/MM/yy"
        return formatter
    }
    
    private func timeString () -> String {
        return timeFormatter.string(from: self)
    }
    
    private func dateString () -> String {
        return dayFormatter.string(from: self)
    }
    
    func timestampString() -> String {
        if Calendar.current.isDateInToday(self){
            return timeString()
        } else if Calendar.current.isDateInYesterday(self) {
            return "ayer"
        } else {
            return dateString()
        }
    }
}
