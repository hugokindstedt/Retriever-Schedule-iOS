//
//  Schematest.swift
//  Retriever
//
//  Created by Hugo Kindstedt on 2025-04-20.
//

import SwiftUI

struct SchemaView: View {
    let events: [Event]
    
    var body: some View {
        List(events){ event in
            EventView(event: event)
        }
    }
}

#Preview {
    SchemaView(events: Event.sampleData)
}
