//
//  ContentView.swift
//  CareKit Sample
//
//  Created by Santiago Gutierrez on 2/13/21.
//

import SwiftUI

struct ContentView: View {
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
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
