//
//  Event.swift
//  Retriever
//
//  Created by Hugo Kindstedt on 2025-04-16.
//

import Foundation

struct Event: Identifiable {
    let id: UUID
    var startDate: String
    var startTime: String
    var startYear: String
    var startMonth: String
    var startDay: String
    var endDate: String
    var endTime: String
    var location: String
    var kursGrp: String
    var sign: String
    var moment: String
            
    init(id: UUID = UUID(), start: String, end: String, location: String, summary: String) {
        self.id = id
        
        startDate = String(start.firstMatch(of: /DTSTART:(\d+)/)?.1 ?? "N/A")
        startTime = String(start.firstMatch(of: /T(\d{4})/)?.1 ?? "N/A")
        
        startYear = String(startDate.prefix(4))
        
        let monthStartIndex = startDate.index(startDate.startIndex, offsetBy: 4)
        let monthEndIndex = startDate.index(monthStartIndex, offsetBy: 2)
        let dayStartIndex = monthEndIndex
        let dayEndIndex = startDate.index(dayStartIndex, offsetBy: 2)
        startMonth = String(startDate[monthStartIndex..<monthEndIndex])
        startDay = String(startDate[dayStartIndex..<dayEndIndex])
        
        endDate = String(end.firstMatch(of: /DTEND:(\d+)/)?.1 ?? "N/A")
        endTime = String(end.firstMatch(of: /T(\d{4})/)?.1 ?? "N/A")
        
        self.location = String(location.firstMatch(of: /LOCATION:(.+)/)?.1 ?? "N/A")
        
        let tempKursGrp = String(summary.firstMatch(of: /Kurs\.grp: (.+?)(?=\s+\w+:|\s*$)/)?.1 ?? "N/A")
        kursGrp = removeDuplicates(input: tempKursGrp)
        
        sign = String(summary.firstMatch(of: /Sign\: (.+?)(?=\s+\w+:|\s*$)/)?.1 ?? "N/A")
        moment = String(summary.firstMatch(of: /Moment\: (.+?)(?=\s+\w+:|\s*$)/)?.1 ?? "N/A")
    }
}
