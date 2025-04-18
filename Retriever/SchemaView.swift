//
//  ContentView.swift
//  Retriever
//
//  Created by Hugo Kindstedt on 2025-04-14.
//

import SwiftUI

struct SchemaView: View {
    var body: some View {
        VStack (alignment: .leading){
            Text("DATE")
                .font(.title)
            
            Section(){
                HStack{
                    Text("START_TIME")
                    Text("-")
                    Text("END_TIME")
                }.bold()
                
                Text("COURSE")
                Text("MOMENT")
                Text("LOCATION")
            }
        }
        .padding(.horizontal)
        .border(Color.gray)
    }
}

#Preview {
    SchemaView()
}
