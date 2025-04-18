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
        VStack (alignment: .leading){
            HStack{

                
            }.font(.title)

            
            HStack{
                HStack(spacing: 0){
                    Text(event.startTime.prefix(2))
                    Text(":")
                    Text(event.startTime.suffix(2))
                    
                    Text(" - ")
                        
                    Text(event.endTime.prefix(2))
                    Text(":")
                    Text(event.endTime.suffix(2))
                }
            }.bold()
            Text(event.kursGrp)
                .foregroundStyle(.orange)
            Text(event.moment)
            Text(event.location)
        }
        .padding(.horizontal)
        .border(Color.gray)
    }
}

#Preview {
    let event: Event = Event.sampleData[0]
    EventView(event: event)
}
