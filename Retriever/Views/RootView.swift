//
//  LandingView.swift
//  Retriever
//
//  Created by Hugo Kindstedt on 2025-04-20.
//

import SwiftUI



struct RootView: View {
    @FetchRequest(sortDescriptors: []) var schedules: FetchedResults<CDSchedule>
    @Environment(\.managedObjectContext) var moc
    
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                Color("BackgroundColor")
                    .ignoresSafeArea(edges: .all)
                
                VStack {
                    ZStack {
                        HStack {
                            SquareLogoView()
                            Text("Retriever")
                                .font(.title)
                                .fontWeight(.bold)
                        }
                        
                        HStack {
                            NavigationLink(value: "SearchView") {
                                Spacer()
                                Text("+")
                                    .font(.title)
                                    .padding(.horizontal, 30)
                                    .foregroundStyle(.blue)
                            }
                        }
                    }
                    
                    List {
                        ForEach(schedules) { schedule in
                            NavigationLink(destination: ScheduleView(schedule: schedule)) {
                                ScheduleMenuView(schedule: schedule)
                                    .allowsHitTesting(false)
                            }
                            .contextMenu {
                                Button(role: .destructive) {
                                    // ACTION
                                    deleteSavedSchedule(in: moc, from: schedules, schedule: schedule)
                                    
                                } label: {
                                    Label("Radera", systemImage: "trash")
                                        
                                }
                                
                            }
                        }
                        .onDelete { offsets in
                            deleteSavedSchedule(in: moc, at: offsets, from: schedules)
                        }
                        /*.onLongPressGesture {
                            print("long press")
                        }*/
                    }
                    .scrollContentBackground(.hidden)
                }
                .foregroundStyle(Color("EventTextColor"))
            }
            .navigationDestination(for: String.self) { identifier in
                if identifier == "SearchView" {
                    SearchView(path: $path)
                }
            }
        }
    }
}

#Preview {
    RootView()
        //.environmentObject()
}

