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
                .fill(Color("DayColor"))
            
            VStack(alignment: .leading){
                HStack(spacing: 0){
                    Text(String(calendar.component(.year, from: day.startDate)))
                    Text("-")
                    Text(String(format: "%02d", calendar.component(.month, from: day.startDate)))
                    Text("-")
                    Text(String(format: "%02d", calendar.component(.day, from: day.startDate)))
                    Text(" ")
                    Text(day.dayOfWeek)
                }
                .font(.headline)
                .foregroundStyle(Color("EventTextColor"))
                
                VStack() {
                    ForEach(day.events){ event in
                        EventView(event: event)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.bottom, 5)
                }
            }
            .padding(10)
        }
        .padding(.vertical, 5)
        .padding(.horizontal, 20)
    }
}

#Preview {
    let day: Day = Day.sampleData[0]
    DayView(day: day)
}
