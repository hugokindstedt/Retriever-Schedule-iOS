//
//  Schematest.swift
//  Retriever
//
//  Created by Hugo Kindstedt on 2025-04-20.
//

import SwiftUI

struct ScheduleView: View {
    let schedule: CDSchedule
    
    @State private var weeks: [Week] = []
    @State private var isLoading: Bool = true
    
    var body: some View {
        ZStack{
            Color("ScheduleBackgroundColor")
                .ignoresSafeArea(.all)
        
        Group {
            if (isLoading) {
                ProgressView()
            } else if (weeks.isEmpty) {
                Text(String(localized: "KronoX svarade med ett tomt schema. Kontrollera schemats resurser."))
            } else {
                    ScrollView{
                        VStack(spacing: 50){
                            ForEach(weeks) { week in
                                WeekView(week: week)
                                
                            }
                        }
                    }
                    .padding(.top, 1)
                    .refreshable {
                        var icalFile: String = ""
                        
                        do{
                            icalFile = try await getSchema(resources: schedule.resources ?? [])
                        } catch {
                            _ = HTTPError.invalidResponse
                            print("ERROR")
                        }
                        
                        let events = parseIcalToEvents(icalFile: icalFile)
                        let days = groupEventsToDays(events: events)
                        weeks = groupDaysToWeeks(days: days)
                    }
                }
            }
        }
        .task {
            var icalFile: String = ""
            
            do{
                icalFile = try await getSchema(resources: schedule.resources ?? [])
            } catch {
                _ = HTTPError.invalidResponse
                print("ERROR")
            }
            
            let events = parseIcalToEvents(icalFile: icalFile)
            let days = groupEventsToDays(events: events)
            weeks = groupDaysToWeeks(days: days)
            print(weeks)
            isLoading = false;
        }
    }
}

#Preview {
    //let schedule = Schedule.sampleData[0]
    
    //ScheduleView(schedule: schedule)
}
