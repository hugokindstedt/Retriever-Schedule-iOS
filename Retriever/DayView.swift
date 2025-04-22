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
        ZStack(alignment: .topLeading){
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.gray.opacity(0.1))
            
            VStack(alignment: .leading){
                HStack(spacing: 0){
                    Text(String(calendar.component(.year, from: day.startDate)))
                    Text("-")
                    Text(String(calendar.component(.month, from: day.startDate)))
                    Text("-")
                    Text(String(calendar.component(.day, from: day.startDate)))
                    Text(" ")
                    Text(day.dayOfWeek)
                }.font(.headline)
                
                VStack() {
                    ForEach(day.events){ event in
                        EventView(event: event)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
            }
        }
        .padding(10)
    }
}

#Preview {
    //let event: [Event] = Event.sampleData
    //DayView(day: day)
}
