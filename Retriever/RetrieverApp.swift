//
//  RetrieverApp.swift
//  Retriever
//
//  Created by Hugo Kindstedt on 2025-04-14.
//

import SwiftUI
//import Foundation

@main
struct RetrieverApp: App {
    @StateObject var scheduleStore = ScheduleStore.preview
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(scheduleStore)
        }
    }
}
