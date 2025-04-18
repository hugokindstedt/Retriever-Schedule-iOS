//
//  Event.swift
//  Retriever
//
//  Created by Hugo Kindstedt on 2025-04-16.
//

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
        
        self.location = String(location.firstMatch(of: /LOCATION:(.+)/)?.1 ?? "N/A")
        
        let tempKursGrp = String(summary.firstMatch(of: /Kurs\.grp: (.+?)(?=\s+\w+:|\s*$)/)?.1 ?? "N/A")
        kursGrp = removeDuplicates(input: tempKursGrp)
        
        sign = String(summary.firstMatch(of: /Sign\: (.+?)(?=\s+\w+:|\s*$)/)?.1 ?? "N/A")
        moment = String(summary.firstMatch(of: /Moment\: (.+?)(?=\s+\w+:|\s*$)/)?.1 ?? "N/A")
    }
}
