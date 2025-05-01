//
//  ScheduleFunctions.swift
//  Retriever
//
//  Created by Hugo Kindstedt on 2025-04-29.
//

import Foundation

func removeDuplicates(input: String) -> String {
    let stringList = input.split(separator: " ")
    
    var wordArr: Array<String> = Array()
    
    for i in stringList {
        if !wordArr.contains(String(i)) {
            wordArr.append(String(i))
        }
    }
    
    var newString: String = ""
    
    for i in wordArr {
        newString.append(i)
        newString.append(" ")
    }
    
    // Remove trailing whitespace
    newString.removeLast(1)
    
    return newString
}

func endpointBuilder(resource: [String]) -> String {
    var endpoint = "https://schema.oru.se/setup/jsp/SchemaICAL.ics?startDatum=idag&intervallTyp=m&intervallAntal=6&sprak=SV&sokMedAND=true&forklaringar=true&resurser="
    
    for i in resource {
        endpoint.append(i)
        endpoint.append(",")
    }
    
    endpoint.removeLast(1)
    
    return endpoint;
}

func getSchema(resources: [String]) async throws -> String {
    // BEHÖVER TESTAS!
    if resources == [] {
        return ""
    }
    
    //let endpoint: String = "https://schema.oru.se/setup/jsp/SchemaICAL.ics?startDatum=idag&intervallTyp=m&intervallAntal=6&sprak=SV&sokMedAND=true&forklaringar=true&resurser=p.H%C3%B6gskoleingenj%C3%B6r+-+Datateknik+%C3%A5k+2-"
    
    let endpoint = endpointBuilder(resource: resources)
    
    print(endpoint)
    
    let url = URL(string: endpoint)!
    
    let (data, response) = try await URLSession.shared.data(from: url)
    
    let HTTPResponse = response as! HTTPURLResponse
    if HTTPResponse.statusCode != 200 {
        throw HTTPError.invalidResponse
    }
    
    let dataString: String = String(data: data, encoding: .utf8)!
    
    return dataString
}

func parseIcalToEvents(icalFile: String) -> [Event]{
    var eventList: [Event] = []
    
    let stringList: [String] = icalFile.components(separatedBy: "BEGIN:VEVENT")

    for i in stringList{
        let eventProperties: [String] = i.components(separatedBy: "\r\n")
        
        if (eventProperties.count < 15){
            continue
        }
        
        let newEvent = Event(start: eventProperties[1], end: eventProperties[2], location: eventProperties[7], summary: eventProperties[10])
        
        eventList.append(newEvent)
    }
    return eventList
}

func groupEventsToDays(events: [Event]) -> [Day]{
    var mutableEvents = events
    var days: [Day] = []
    
    while !mutableEvents.isEmpty {
        let currentEvent = mutableEvents.removeFirst()
        var eventsOnSameDay: [Event] = [currentEvent]
        
        // Remove all events on that date and append them to eventsOnsameDay
        mutableEvents.removeAll { (event) -> Bool in
            let dateFormat = Date.FormatStyle(date: .long, time: .omitted)
            
            if dateFormat.format(event.startDate) == dateFormat.format(currentEvent.startDate) {
                eventsOnSameDay.append(event)
                return true
            }
            return false
        }
     
        let newDay = Day(startDate: eventsOnSameDay[0].startDate, events: eventsOnSameDay)
        
        days.append(newDay)
    }
    return days
}

func groupDaysToWeeks(days: [Day]) -> [Week]{
    var mutableDays = days
    var weeks: [Week] = []
    
    let calendar: Calendar = Calendar.current
    
    while !mutableDays.isEmpty {
        let currentDay = mutableDays.removeFirst()
        var daysInSameWeek: [Day] = [currentDay]
        
        // Remove all days on that date and append them to daysInSameWeek
        mutableDays.removeAll { (day) -> Bool in
            if calendar.component(.weekOfYear, from: day.startDate) == calendar.component(.weekOfYear, from: currentDay.startDate) {
                daysInSameWeek.append(day)
                return true
            }
            return false
        }
        
        let weekNumber = calendar.component(.weekOfYear, from: currentDay.startDate)
        let newWeek = Week(weekNumber: weekNumber, days: daysInSameWeek)
        
        weeks.append(newWeek)
    }
    return weeks
}

/*func getWeekNumber() -> Int {
    let calendar = Calendar(identifier: .gregorian)
    let components = calendar.dateComponents([.weekOfYear], from: Date())
    return components.weekOfYear ?? 0
}*/

enum HTTPError: Error {
    case invalidResponse
}
