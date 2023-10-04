//
//  InfanDateFormatter.swift
//  Infantory
//
//  Created by 김성훈 on 2023/10/04.
//

import Foundation

class InfanDateFormatter {
    static let shared = InfanDateFormatter()
    
    private init() {}
        
    private let dateAndTimeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "M/dd h:MM"
        formatter.locale = Locale.current
        
        return formatter
    }()
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "M/dd"
        formatter.locale = Locale.current
        
        return formatter
    }()
    
    private let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:MM:SS"
        formatter.locale = Locale.current
        
        return formatter
    }()

    /// M/D h:MM
    func dateTimeString(from date: Date) -> String {
        return dateAndTimeFormatter.string(from: date)
    }
    
    /// M/D
    func dateString(from date: Date) -> String {
        return dateFormatter.string(from: date)
    }
    
    /// HH:MM:SS
    func timeString(from date: Date) -> String {
        return timeFormatter.string(from: date)
    }
    
}
