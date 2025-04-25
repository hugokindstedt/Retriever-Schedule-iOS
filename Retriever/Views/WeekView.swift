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
        VStack(alignment: .leading, spacing: 0){
            HStack(){
                HStack(){
                    Text("V.")
                    Text(String(week.weekNumber))
                }
                .font(.headline)
                
                // Used for a horizontal divider
                VStack(){
                    Divider()
                        .overlay(Color("EventTextColor"))
                }
            }
            .padding(.horizontal, 20)
            .foregroundStyle(Color("EventTextColor"))

            VStack(){
                ForEach(week.days){day in
                    DayView(day: day)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
    }
}

#Preview {
    //WeekView()
}
