import Foundation

extension Day {
    static let sampleData: [Day] = [
        Day(
            startDate: ISO8601DateFormatter().date(from: "2025-04-14T08:00:00Z")!,
            events: [
                Event(start: "DTSTART:20250414T061500Z", end: "DTEND:20250414T080000Z", location: "LOCATION:T129", summary: "SUMMARY:Program: Högskoleingenjör - Datateknik åk 2- Kurs.grp: Realtidsprogrammering Realtidsprogrammering Sign: prd Moment: Realtidsprogrammering Aktivitetstyp: Okänd"),
                Event(start: "DTSTART:20250415T061500Z", end: "DTEND:20250415T080000Z", location: "LOCATION:T101", summary: "SUMMARY:Program: Högskoleingenjör - Datateknik åk 2- Kurs.grp: Realtidsprogrammering Realtidsprogrammering Sign: prd Moment: Realtidsprogrammering Aktivitetstyp: Okänd"),
                Event(start: "DTSTART:20250415T081500Z", end: "DTEND:20250415T100000Z", location: "LOCATION:Hörsal M", summary: "SUMMARY:Program: Högskoleingenjör - Datateknik åk 2- Kurs.grp: Realtidsprogrammering Realtidsprogrammering Sign: prd Moment: Realtidsprogrammering Aktivitetstyp: Okänd")
            ]
        )
    ]
}
