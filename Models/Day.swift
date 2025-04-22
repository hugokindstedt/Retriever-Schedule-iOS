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

        //self.weekOfYear = Calendar.current.component(.weekOfYear, from: startDate)
       
        let weekDayFormatter = DateFormatter()
        weekDayFormatter.dateFormat = "EEEE"
        self.dayOfWeek = weekDayFormatter.string(from: startDate)
        
        /*
        let test = Date.FormatStyle()
            .year(.omitted)
            .month(.omitted)
            .day(.omitted)
            .weekday()
        
        dayOfWeek = test.format(startDate)
        */
        self.events = events
    }
}
