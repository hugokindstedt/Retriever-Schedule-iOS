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
                .font(.title)
                .padding(.horizontal, 5)
                
                // Horizontal divider
                VStack(){
                    Divider()
                }
            }

            VStack(){
                ForEach(week.days){day in
                    DayView(day: day)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            //.border(Color.blue)
        }//.contentMargins(.all, 10)
    }
}

#Preview {
    //WeekView()
}
