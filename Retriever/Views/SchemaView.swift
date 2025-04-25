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
        ZStack{
            Color("BackgroundColor")
                .ignoresSafeArea(.all)
            
            ScrollView{
                VStack(spacing: 50){
                    ForEach(weeks) { week in
                        WeekView(week: week)
                    }
                }
            }
            .padding(.top, 1)
            .refreshable {
                // TODO
            }
        }
    }
}

#Preview {
    //SchemaView(events: Event.sampleData)
}
