//
//  DataController.swift
//  Retriever
//
//  Created by Hugo Kindstedt on 2025-05-01.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "Retriever")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("CoreData failed to load! \(error.localizedDescription)")
            }
        }
    }
}
