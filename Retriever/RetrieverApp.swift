//
//  RetrieverApp.swift
//  Retriever
//
//  Created by Hugo Kindstedt on 2025-04-14.
//

import SwiftUI
import Foundation

@main
struct RetrieverApp: App {
    var body: some Scene {
        WindowGroup {
            SchemaView()
        }
    }
}

/*
struct Event {
    var startDate: String
    var startTime: String
    var endDate: String
    var endTime: String
    var location: String
    var kursGrp: String
    var sign: String
    var moment: String
            
    init(start: String, end: String, location: String, summary: String) {
        startDate = String(start.firstMatch(of: /DTSTART:(\d+)/)?.1 ?? "N/A")
        startTime = String(start.firstMatch(of: /T(\d{4})/)?.1 ?? "N/A")
        
        endDate = String(end.firstMatch(of: /DTEND:(\d+)/)?.1 ?? "N/A")
        endTime = String(end.firstMatch(of: /T(\d{4})/)?.1 ?? "N/A")
        
        self.location = location
        
        let tempKursGrp = String(summary.firstMatch(of: /Kurs\.grp: (.+?)(?=\s+\w+:|\s*$)/)?.1 ?? "N/A")
        kursGrp = removeDuplicates(input: tempKursGrp)
        
        sign = String(summary.firstMatch(of: /Sign\: (.+?)(?=\s+\w+:|\s*$)/)?.1 ?? "N/A")
        moment = String(summary.firstMatch(of: /Moment\: (.+?)(?=\s+\w+:|\s*$)/)?.1 ?? "N/A")
    }
}
*/

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

func getSchema() async throws -> String {
    let endpoint: String = "https://schema.oru.se/setup/jsp/SchemaICAL.ics?startDatum=idag&intervallTyp=m&intervallAntal=6&sprak=SV&sokMedAND=true&forklaringar=true&resurser=p.H%C3%B6gskoleingenj%C3%B6r+-+Datateknik+%C3%A5k+2-"
    
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

//print("Hello, World!")

//var icalFile: String = try await getSchema()

//var events = parseIcalToEvents(icalFile: icalFile)

/*for i in events{
    print(i)
    print("\n")
}*/

enum HTTPError: Error {
    case invalidResponse
}
