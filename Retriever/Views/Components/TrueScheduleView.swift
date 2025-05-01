//
//  TrueScheduleView.swift
//  Retriever
//
//  Created by Hugo Kindstedt on 2025-04-29.
//

import SwiftUI

struct TrueScheduleView: View {
    let schedule: CDSchedule
    
    var body: some View {
        VStack(alignment: .leading){
            Text(schedule.name ?? "NO NAME")
                .font(.headline)
            ForEach(Array(schedule.resources ?? []), id: \.self){ resource in
                Text(convertResourceToReadableString(resource: resource))
                    .font(.footnote)
            }
        }
    }
}

#Preview {
    //let schedule = Schedule.sampleData[0]
    //TrueScheduleView(schedule: schedule)
}
