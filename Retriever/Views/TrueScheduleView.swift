//
//  TrueScheduleView.swift
//  Retriever
//
//  Created by Hugo Kindstedt on 2025-04-29.
//

import SwiftUI

struct TrueScheduleView: View {
    let schedule: Schedule
    
    var body: some View {
        VStack(alignment: .leading){
            Text(schedule.name)
                .font(.headline)
            ForEach(Array(schedule.resources), id: \.self){ resource in
                Text(convertResourceToReadableString(resource: resource))
                    .font(.footnote)
            }
        }
    }
}

#Preview {
    let schedule = Schedule.sampleData[0]
    TrueScheduleView(schedule: schedule)
}
