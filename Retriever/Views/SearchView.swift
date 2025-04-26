//
//  SearchView.swift
//  Retriever
//
//  Created by Hugo Kindstedt on 2025-04-23.
//

import SwiftUI

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

struct SearchView: View {
    //@Environment(\.editMode) private var editMode
    @State private var editMode: EditMode = .inactive
    
    @State private var searchText: String = ""
    @State private var searchResult: String = ""
    @State private var results: [SearchResult] = []
    
    @State private var multiSelection = Set<String>()
    
    var body: some View {
            HStack{
                TextField("Sök schema", text: $searchText)
                    .padding(6)
                    .background(Color.gray.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .padding(.horizontal)
                Button("Sök") {
                    Task{
                        do {
                            searchResult = try await searchSchedule(searchTerm: searchText)
                        } catch {
                            // FIXA LOGIK
                            _ = HTTPError.invalidResponse
                        }
                        results = parseSearchHtml(html: searchResult)
                        //print(results)
                        editMode = .active
                    }
                }
                .buttonStyle(.bordered)
                
            }
            .padding(.horizontal)
            
            List(results, selection: $multiSelection){ result in
                SearchResultView(result: result)
            }
            .listStyle(PlainListStyle())
            .environment(\.editMode, $editMode)
            .padding(0)
            
        if(!multiSelection.isEmpty){
            Button("Visa val") {
                if !multiSelection.isEmpty {
                    print("Val: \(multiSelection)")
                }
            }
            .buttonStyle(.borderedProminent)
        }

        Text("\(multiSelection.count) selections")
        }
}


#Preview {
    SearchView()
}
