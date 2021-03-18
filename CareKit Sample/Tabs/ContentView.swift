//
//  ContentView.swift
//  CareKit Sample
//
//  Created by Santiago Gutierrez on 2/13/21.
//

import SwiftUI
import SwiftUICharts

struct ContentView: View {
    let color: Color
    let config = Config.shared
    
    init() {
        self.color = Color(config.readColor(query: "Primary Color"))
    }

    var body: some View {
        TabView {
            
            ScheduleViewControllerRepresentable()
                .tabItem {
                    Image("tab_schedule").renderingMode(.template)
                    Text("Schedule")
                }
            
            LineView(data: [8,23,54,32,12,37,7,23,43],
                     title: "Line chart",
                     legend: "Full screen")
                .padding(10)
                .tabItem {
                    Image("tab_tasks").renderingMode(.template)
                    Text("Chart")
                }
            
            CareTeamViewControllerRepresentable()
                .tabItem {
                    Image("tab_profile").renderingMode(.template)
                    Text("Contact")
                }
        }
        .accentColor(self.color)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
