//
//  SearchResult.swift
//  Retriever
//
//  Created by Hugo Kindstedt on 2025-04-24.
//

import Foundation

struct SearchResult: Identifiable {
    let id: String
    let resource: String
    let title: String
    let type: String
    
    init(resource: String, title: String) {
        self.id = resource
        
        self.resource = resource
        self.title = title
        
        if(resource.hasPrefix("p.")) {
            self.type = "Program"
        } else if(resource.hasPrefix("k.")){
            self.type = "Kurs"
        }else {
            self.type = "Lokal"
        }
    }
}
