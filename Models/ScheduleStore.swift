//
//  ScheduleStore.swift
//  Retriever
//
//  Created by Hugo Kindstedt on 2025-04-29.
//

import Foundation

class ScheduleStore: ObservableObject {
    @Published var schedules: [Schedule] = []
}
