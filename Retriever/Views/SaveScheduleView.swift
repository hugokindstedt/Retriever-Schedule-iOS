//
//  SaveScheduleView.swift
//  Retriever
//
//  Created by Hugo Kindstedt on 2025-04-27.
//

import SwiftUI

struct SaveScheduleView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var schedules: FetchedResults<CDSchedule>
    
    let multiSelection: Set<String>
    @Binding var path: NavigationPath
    
    @Environment(\.colorScheme) private var colorScheme
    @State private var scheduleName: String = ""
    @FocusState private var isFocused: Bool
    
    var body: some View {
        
        let selectedResources = Array(multiSelection).sorted()
        
        ZStack {
            Color("BackgroundColor")
                .ignoresSafeArea(.all)
            
            Form{
                Section(header: Text(String(localized: "Namn"))){
                    TextField(text: $scheduleName, prompt: Text(String(localized: "Krävs"))) {
                        Text(String(localized: "Namn"))
                    }
                    .focused($isFocused)
                    .overlay{
                        HStack{
                            Spacer()
                            
                            if(!scheduleName.isEmpty){
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundStyle(Color.gray)
                                    .padding(0)
                                    .onTapGesture {
                                        scheduleName = ""
                                        isFocused = true
                                    }
                            }
                        }
                    }
                }
                
                
                Section(header: Text(String(localized: "Valda resurser"))){
                    List{
                        ForEach(selectedResources, id: \.self) { resource in
                            Text(convertResourceToReadableString(resource: resource))
                        }
                    }
                }
                
                Section{
                    Button(String(localized: "Spara")) {
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
                    .disabled(scheduleName.isEmpty == true ? true : false)
                }
                .listRowInsets(EdgeInsets())
            }
            .navigationTitle(Text(String(localized: "Spara schemat")))
            .scrollContentBackground(colorScheme == .dark ? .hidden : .visible)
            .foregroundStyle(Color("EventTextColor"))
        }
        .onAppear {
            scheduleName = String(localized: "Nytt schema \(schedules.count+1)")
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
