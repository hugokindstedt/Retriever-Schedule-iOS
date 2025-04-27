//
//  SearchFunctions.swift
//  Retriever
//
//  Created by Hugo Kindstedt on 2025-04-27.
//

import Foundation

func searchSchedule(searchTerm: String) async throws -> String {
    let endpoint: String = "https://schema.oru.se/ajax/ajax_sokResurser.jsp?sokord=\(searchTerm)&startDatum=idag&slutDatum=&intervallTyp=m&intervallAntal=6"
    
    //print(endpoint)
    
    guard let url = URL(string: endpoint) else { return "URL init failed" }
    
    let (data, response) = try await URLSession.shared.data(from: url)
    
    let HTTPResponse = response as! HTTPURLResponse
    if HTTPResponse.statusCode != 200 {
        throw HTTPError.invalidResponse
    }
    
    guard let dataString: String = String(data: data, encoding: .utf8) else { return "String encoding failed" }
    
    return dataString
}

func parseSearchHtml(html: String) -> [SearchResult] {
    var searchResults: [SearchResult] = []
    
    let matches = html.matches(of: /<a [^>]*?href="[^"]*?&resurser=([^"&]+)[^"]*"[^>]*?>([^<]+)<\/a>/)
    
    for match in matches {
        let result: SearchResult = SearchResult(resource: String(match.1), title: String(match.2))
        searchResults.append(result)
    }
    
    return searchResults
}
