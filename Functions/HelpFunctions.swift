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
