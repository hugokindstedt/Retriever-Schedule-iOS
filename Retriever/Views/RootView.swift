//
//  LandingView.swift
//  Retriever
//
//  Created by Hugo Kindstedt on 2025-04-20.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var scheduleStore: ScheduleStore
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
                            NavigationLink(value: 1) {
                                Spacer()
                                Text("+")
                                    .font(.title)
                                    .padding(.horizontal, 30)
                            }
                        }
                    }
                    
                    List {
                        ForEach(scheduleStore.schedules) { schedule in
                            NavigationLink(destination: ScheduleView(schedule: schedule)) {
                                TrueScheduleView(schedule: schedule)
                            }
                        }
                    }
                    .scrollContentBackground(.hidden)
                }
                .foregroundStyle(Color("EventTextColor"))
            }
            .navigationDestination(for: Int.self) { identifier in
                if identifier == 1 {
                    SearchView(path: $path)
                }
            }
        }
    }
}

#Preview {
    RootView()
        .environmentObject(ScheduleStore.preview)
}

