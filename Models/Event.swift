//
//  Event.swift
//  Retriever
//
//  Created by Hugo Kindstedt on 2025-04-16.
//

import Foundation

struct Event: Identifiable {
    let id: UUID
    
    let startDate: Date
    let endDate: Date
    
    /*let startDate: String
    let startTime: String
    let startYear: String
    let startMonth: String
    let startDay: String*/
    
    
    /*let endDate: String
    let endTime: String*/
    
    let location: String
    let kursGrp: String
    let sign: String
    let moment: String
            
    init(id: UUID = UUID(), start: String, end: String, location: String, summary: String) {
        self.id = id
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd'T'HHmmssZ"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        let inputStartDate = String(start.suffix(16))
        //print(startDateTest2)
        startDate = dateFormatter.date(from: inputStartDate)!
        
        let inputEndDate = String(end.suffix(16))
        endDate = dateFormatter.date(from: inputEndDate)!
        
        self.location = String(location.firstMatch(of: /LOCATION:(.+)/)?.1 ?? "N/A")
        
        let tempKursGrp = String(summary.firstMatch(of: /Kurs\.grp: (.+?)(?=\s+\w+:|\s*$)/)?.1 ?? "N/A")
        kursGrp = removeDuplicates(input: tempKursGrp)
        
        sign = String(summary.firstMatch(of: /Sign\: (.+?)(?=\s+\w+:|\s*$)/)?.1 ?? "N/A")
        moment = String(summary.firstMatch(of: /Moment\: (.+?)(?=\s+\w+:|\s*$)/)?.1 ?? "N/A")
    }
}
