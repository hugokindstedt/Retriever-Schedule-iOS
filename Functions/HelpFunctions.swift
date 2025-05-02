//
//  HelpFunctions.swift
//  Retriever
//
//  Created by Hugo Kindstedt on 2025-04-29.
//

import Foundation
import CoreData
import SwiftUI

func convertResourceToReadableString(resource: String) -> String {
    let decodedString = resource
        .replacingOccurrences(of: "+", with: " ")
        .removingPercentEncoding ?? resource

    // Remove p. k. etc from the beginning of the string
    return String(decodedString.dropFirst(2))
}

func deleteSavedSchedule(in moc: NSManagedObjectContext, at offsets: IndexSet, from schedules: FetchedResults<CDSchedule>) {
    for offset in offsets {
        let schedule = schedules[offset]
        moc.delete(schedule)
    }
    
    do {
        try moc.save()
    } catch {
        print("ERROR SAVING SCHEDULE UPDATE: \(error)")
    }
}

func deleteSavedSchedule(in moc: NSManagedObjectContext, from schedules: FetchedResults<CDSchedule>, schedule: FetchedResults<CDSchedule>.Element) {
    if let index = schedules.firstIndex(where: { $0.id == schedule.id }) {
        deleteSavedSchedule(in: moc, at: IndexSet(integer: index), from: schedules)
    }
}
