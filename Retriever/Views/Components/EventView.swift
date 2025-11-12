//
//  CardView.swift
//  Retriever
//
//  Created by Hugo Kindstedt on 2025-04-16.
//

import SwiftUI

struct EventView: View {
    let event: Event
    @State private var showSign = false
    
    var body: some View {
        let calendar = Calendar.current
        
        VStack (alignment: .leading){
            HStack(){
                HStack(spacing: 0){
                    // %02d gives leading or trailing zero
                    Text(String(format: "%02d", calendar.component(.hour, from: event.startDate)))
                    Text(":")
                    Text(String(format: "%02d", calendar.component(.minute, from: event.startDate)))
                    Text(" - ")
                    Text(String(format: "%02d", calendar.component(.hour, from: event.endDate)))
                    Text(":")
                    Text(String(format: "%02d", calendar.component(.minute, from: event.endDate)))
                }
            }
            .bold()
            
            Text(event.kursGrp)
                .foregroundStyle(.orange)
            
            if (event.moment.contains(/Tenta/.ignoresCase())) {
                Text(event.moment)
                    .padding(5)
                    .background(Color.orange)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .foregroundColor(.black)
            } else {
                Text(event.moment)
            }
            
            Text(event.location)
            
            if(showSign){
                Text(event.sign)
            }
            
        }
        .padding(.horizontal)
        .foregroundStyle(Color("EventTextColor"))
        
        // Make the whole event tapable
        .frame(maxWidth: .infinity, alignment: .leading)
        .contentShape(Rectangle())
        
        .onTapGesture {showSign.toggle()}
    }
}

#Preview {
    let event: Event = Event.sampleData[0]
    EventView(event: event)
}
