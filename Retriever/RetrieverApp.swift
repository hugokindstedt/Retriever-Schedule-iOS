//
//  RetrieverApp.swift
//  Retriever
//
//  Created by Hugo Kindstedt on 2025-04-14.
//

import SwiftUI

@main
struct RetrieverApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
