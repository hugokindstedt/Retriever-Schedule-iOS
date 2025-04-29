//
//  SearchView.swift
//  Retriever
//
//  Created by Hugo Kindstedt on 2025-04-23.
//

import SwiftUI

struct SearchView: View {
    //@Environment(\.editMode) private var editMode
    @Binding var path: NavigationPath
    
    @State private var editMode: EditMode = .inactive
    @State private var searchText: String = ""
    @State private var searchResult: String = ""
    @State private var results: [SearchResult] = []
    @State private var multiSelection = Set<String>()
    
    @FocusState private var isFocused: Bool
    
    var body: some View {
        ZStack {
            Color("BackgroundColor")
                .ignoresSafeArea(edges: .all)
            VStack {
                /*HStack{
                 SquareLogoView()
                 Text("Retriever")
                 .font(.title)
                 .fontWeight(.bold)
                 }*/
                
                HStack{
                    TextField("Sök efter program, kurs eller annan resurs", text: $searchText)
                        .padding(6)
                        .background(Color.gray.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .padding(.horizontal)
                        .submitLabel(.search)
                        .focused($isFocused)
                        .onSubmit {
                            Task {
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
                        .overlay{
                            HStack{
                                Spacer()
                                
                                if(!searchText.isEmpty){
                                    Button(action: {
                                        searchText = ""
                                        results.removeAll()
                                    }) {
                                        Image(systemName: "xmark.circle.fill")
                                            .foregroundStyle(Color.gray)
                                            .padding(20)
                                    }
                                }
                            }
                        }
                }
                .padding(.horizontal, 2)
                
                List(results, selection: $multiSelection){ result in
                    SearchResultView(result: result)
                }
                .scrollContentBackground(.hidden)
                //.listStyle(PlainListStyle())
                .environment(\.editMode, $editMode)
                .padding(0)
                
                if(!multiSelection.isEmpty){
                    Text("\(multiSelection.count) val")
                    
                    NavigationLink(destination: SaveScheduleView(multiSelection: multiSelection, path: $path)) {
                        Text("Spara")
                            .padding(.horizontal, 10)
                            .padding(.vertical, 7)
                            .background(Color.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .foregroundStyle(Color.white)
                        
                    }
                }
            }
        }
        .navigationTitle(Text("Skapa nytt schema"))
        .foregroundStyle(Color("EventTextColor"))
        .onAppear {
            isFocused = true
        }
    }
}

#Preview {
    SearchView(path: .constant(NavigationPath()))
}
