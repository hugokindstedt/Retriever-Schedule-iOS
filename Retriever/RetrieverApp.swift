//
//  RetrieverApp.swift
//  Retriever
//
//  Created by Hugo Kindstedt on 2025-04-14.
//

import SwiftUI
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

enum HTTPError: Error {
    case invalidResponse
}

@main
struct RetrieverApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}

struct RootView: View {
    @State private var events: [Event] = []
    @State private var isLoading = true
    
    var body: some View {
        Group {
            if isLoading {
                Text("Loading...")
            } else {
                SchemaView(events: events)
            }
        }
        .task {
            print("Hello, World!")
            
            var icalFile: String = ""
            
            do{
                icalFile = try await getSchema()
            } catch {
                _ = HTTPError.invalidResponse
                print("ERROR")
            }
            
            events = parseIcalToEvents(icalFile: icalFile)
            
            /*
            for i in events{
                print(i)
                print("\n")
            }
            */
            
            isLoading = false
        }
    }
}
