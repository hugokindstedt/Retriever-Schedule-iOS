//
//  HelpFunctions.swift
//  Retriever
//
//  Created by Hugo Kindstedt on 2025-04-29.
//

import Foundation

func convertResourceToReadableString(resource: String) -> String {
    let decodedString = resource
        .replacingOccurrences(of: "+", with: " ")
        .removingPercentEncoding ?? resource

    // Remove p. k. etc from the beginning of the string
    return String(decodedString.dropFirst(2))
}
