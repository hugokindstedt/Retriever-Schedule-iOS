//
//  DayView.swift
//  Retriever
//
//  Created by Hugo Kindstedt on 2025-04-20.
//

import SwiftUI

struct DayView: View {
    let day: Day
    let calendar: Calendar = .current
    
    var body: some View {
        HStack(spacing: 0){
            Text(String(calendar.component(.year, from: day.startDate)))
            Text("-")
            Text(String(calendar.component(.month, from: day.startDate)))
            Text("-")
            Text(String(calendar.component(.day, from: day.startDate)))
            Text(" ")
            Text(day.dayOfWeek)
        }.font(.headline)

        VStack(alignment: .leading, spacing: 10) {
            ForEach(day.events){ event in
                EventView(event: event)
            }
        }
    }
}

#Preview {
    //let event: [Event] = Event.sampleData
    //DayView(day: day)
}
