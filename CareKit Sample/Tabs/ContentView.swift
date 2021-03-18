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
            
            if let arr = (UserDefaults.standard.array(forKey: "user_default_array") ?? []) as? [Double] {
                LineView(data: arr,
                         title: "Line chart",
                         legend: "Full screen")
                    .padding(10)
                    .tabItem {
                        Image("tab_tasks").renderingMode(.template)
                        Text("Chart")
                    }
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
