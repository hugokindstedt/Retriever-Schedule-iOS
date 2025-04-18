//
//  CardView.swift
//  Retriever
//
//  Created by Hugo Kindstedt on 2025-04-16.
//

import SwiftUI

struct CardView: View {
    let event: Event
    var body: some View {
        VStack(alignment: .leading) {
            
        }
        Text(event.startDate)
            .font(.title)
    }
}

#Preview {
    let event: Event = Event.sampleData[0]
    CardView(event: event)
}
