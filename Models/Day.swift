//
//  Day.swift
//  Retriever
//
//  Created by Hugo Kindstedt on 2025-04-21.
//

import Foundation

struct Day: Identifiable {
    let id: Date
    
    let startDate: Date
    let dayOfWeek: String
    let events: [Event]
    
    init(startDate: Date, events: [Event]){
        self.id = startDate
        
        self.startDate = startDate
       
        let weekDayFormatter = DateFormatter()
        weekDayFormatter.locale = Locale(identifier: Locale.preferredLanguages.first ?? "en_US")
        weekDayFormatter.setLocalizedDateFormatFromTemplate("EEEE")
        self.dayOfWeek = weekDayFormatter.string(from: startDate).capitalized
        
        self.events = events
    }
}
