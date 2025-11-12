//
//  SearchResultView.swift
//  Retriever
//
//  Created by Hugo Kindstedt on 2025-04-24.
//

import SwiftUI

struct SearchResultView: View {
    let result: SearchResult
    
    var body: some View {
        VStack(alignment: .leading){
            //Text(result.resource)
            Text(result.title)
            Text(result.type)
                .font(.subheadline)
                .fontWeight(.thin)
        }
    }
}

#Preview {
    //let result: SearchResult = SearchResult.sampleData[0]
    //SearchResultView(result: result)
}
