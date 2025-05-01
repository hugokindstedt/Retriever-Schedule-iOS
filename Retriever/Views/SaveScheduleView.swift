//
//  SaveScheduleView.swift
//  Retriever
//
//  Created by Hugo Kindstedt on 2025-04-27.
//

import SwiftUI

struct SaveScheduleView: View {
    @Environment(\.managedObjectContext) var moc
    
    let multiSelection: Set<String>
    @Binding var path: NavigationPath
    @State private var scheduleName: String = ""
    @FocusState private var isFocused: Bool
    
    var body: some View {
        let selectedResources = Array(multiSelection).sorted()
        
        ZStack {
            Color("BackgroundColor")
                .ignoresSafeArea(.all)
            
            Form{
                Section(header: Text("Namn")){
                    TextField(text: $scheduleName, prompt: Text("Krävs")) {
                        Text("Namn")
                    }
                    .focused($isFocused)
                }
                
                Section(header: Text("Valda resurser")){
                    List{
                        ForEach(selectedResources, id: \.self) { resource in
                            Text(convertResourceToReadableString(resource: resource))
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
                        Button("Spara") {
                            let newSchedule = CDSchedule(context: moc)
                            newSchedule.id = UUID()
                            newSchedule.name = scheduleName
                            newSchedule.resources = selectedResources
                            
                            do {
                                try moc.save()
                            } catch {
                                print("ERROR SAVING NEW SCHEDULE: \(error)")
                            }
                            
                            path = NavigationPath()
                        }
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                        .padding()
                        .background(Color.blue)
                    }
                }
                .listRowInsets(EdgeInsets())
            }
            .navigationTitle(Text("Spara schemat"))
            .scrollContentBackground(.hidden)
            .foregroundStyle(Color("EventTextColor"))
        }
        .onAppear {
            isFocused = true
        }
    }
}

#Preview {
    NavigationStack {
        let multiSelection: Set<String> = ["p.Biologiprogrammet+%C3%A5k+3-", "p.H%C3%B6gskoleingenj%C3%B6r+-+Datateknik+%C3%A5k+2-"]

        SaveScheduleView(multiSelection: multiSelection, path: .constant(NavigationPath()))
    }
}
