//
//  ContentView.swift
//  CareKit Sample
//
//  Created by Santiago Gutierrez on 2/13/21.
//

import SwiftUI

struct ContentView: View {
    let color: Color
    let config = Config.shared
    
    init() {
        self.color = Color(config.readColor(query: "Primary Color"))
    }

    var body: some View {
        TabView {
            ScheduleViewControllerRepresentable().tabItem {
                Image("tab_schedule").renderingMode(.template)
                Text("Schedule")
            }
            
            CareTeamViewControllerRepresentable().tabItem {
                Image("tab_care").renderingMode(.template)
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
