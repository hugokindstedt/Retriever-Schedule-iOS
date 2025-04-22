//
//  CardView.swift
//  Retriever
//
//  Created by Hugo Kindstedt on 2025-04-16.
//

import SwiftUI

struct EventView: View {
    let event: Event
    
    var body: some View {
        let calendar = Calendar.current
        
        VStack (alignment: .leading){
            HStack(){
                HStack(spacing: 0){
                    Text(String(calendar.component(.hour, from: event.startDate)))
                    Text(":")
                    Text(String(calendar.component(.minute, from: event.startDate)))
                    Text(" - ")
                    Text(String(calendar.component(.hour, from: event.endDate)))
                    Text(":")
                    Text(String(calendar.component(.minute, from: event.endDate)))
                }
            }.bold()
            
            Text(event.kursGrp)
                .foregroundStyle(.orange)
            Text(event.moment)
            Text(event.location)
        }
        .padding(.horizontal)
    }
}

#Preview {
    let event: Event = Event.sampleData[0]
    EventView(event: event)
}
