//
//  Schedule.swift
//  Retriever
//
//  Created by Hugo Kindstedt on 2025-04-27.
//

import Foundation

struct Schedule: Identifiable {
    let id: UUID
    let name: String
    let resources: Set<String>
    
    init(id: UUID = UUID(), name: String, resources: Set<String>) {
        self.id = id
        
        self.name = name
        self.resources = resources
    }
}
