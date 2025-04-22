//
//  Schematest.swift
//  Retriever
//
//  Created by Hugo Kindstedt on 2025-04-20.
//

import SwiftUI

struct SchemaView: View {
    let weeks: [Week]
    
    var body: some View {
            ScrollView{
                VStack(spacing: 50){
                    ForEach(weeks) { week in
                        WeekView(week: week)
                    }
                }
            }
    }
}

#Preview {
    //SchemaView(events: Event.sampleData)
}
