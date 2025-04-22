//
//  Week.swift
//  Retriever
//
//  Created by Hugo Kindstedt on 2025-04-22.
//

import Foundation

struct Week: Identifiable{
    let id: Int
    let weekNumber: Int
    let days: [Day]
    
    init(weekNumber: Int, days: [Day]) {
        self.id = weekNumber
        self.weekNumber = weekNumber
        self.days = days
    }
}
