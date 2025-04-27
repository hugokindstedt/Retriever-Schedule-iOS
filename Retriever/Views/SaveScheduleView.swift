//
//  SaveScheduleView.swift
//  Retriever
//
//  Created by Hugo Kindstedt on 2025-04-27.
//

import SwiftUI

struct SaveScheduleView: View {
    let multiSelection: Set<String>
    
    @State var scheduleName: String = ""
    
    var body: some View {
        NavigationStack{
            ZStack {
                Color("BackgroundColor")
                    .ignoresSafeArea(.all)
                
                Form{
                    Section(header: Text("Namn")){
                        TextField(text: $scheduleName, prompt: Text("Krävs")) {
                            Text("Namn")
                        }
                    }
                    Section(header: Text("Valda resurser")){
                        List{
                            ForEach(Array(multiSelection), id: \.self) { item in
                                let decodedString = item
                                    .replacingOccurrences(of: "+", with: " ")
                                    .removingPercentEncoding ?? item
                                
                                // Remove p. k. etc from the beginning of the string
                                Text(String(decodedString.dropFirst(2)))
                            }
                        }
                    }
                    Section{
                        // Disable button if no name has been given to the schedule
                        if(scheduleName.isEmpty) {
                            Button("Spara") {  }
                                .frame(maxWidth: .infinity)
                                .foregroundStyle(.white)
                                .fontWeight(.bold)
                                .padding()
                                .background(Color.blue)
                                .disabled(true)
                        } else {
                            Button("Spara") {  }
                                .frame(maxWidth: .infinity)
                                .foregroundStyle(.white)
                                .fontWeight(.bold)
                                .padding()
                                .background(Color.blue)
                        }
                    }
                    .listRowInsets(EdgeInsets())
                }
                .scrollContentBackground(.hidden)
            }
            .navigationTitle(Text("Spara schemat"))
            .foregroundStyle(Color("EventTextColor"))
        }
    }
}

#Preview {
    NavigationStack {
        let multiSelection: Set<String> = ["p.Biologiprogrammet+%C3%A5k+3-", "p.H%C3%B6gskoleingenj%C3%B6r+-+Datateknik+%C3%A5k+2-"]
        
        SaveScheduleView(multiSelection: multiSelection)
    }
}
