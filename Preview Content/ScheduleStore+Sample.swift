//
//  ScheduleStore+Sample.swift
//  Retriever
//
//  Created by Hugo Kindstedt on 2025-04-29.
//

extension ScheduleStore {
    static var preview: ScheduleStore {
        let store = ScheduleStore()
        store.schedules.append(Schedule.sampleData[0])
        store.schedules.append(Schedule.sampleData[1])
        return store
    }
}
