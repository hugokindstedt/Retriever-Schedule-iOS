//
//  WeekView.swift
//  Retriever
//
//  Created by Hugo Kindstedt on 2025-04-22.
//

import SwiftUI

struct WeekView: View {
    let week: Week
    
    
    var body: some View {
        //Text(String(week.weekNumber))
        
        VStack(alignment: .leading){
            HStack(){
                Text("V.")
                Text(String(week.weekNumber))
            }
                .font(.title)
            
            Section(){
                ForEach(week.days){day in
                    DayView(day: day)
                }
            }

        }
    }
}

#Preview {
    //WeekView()
}
