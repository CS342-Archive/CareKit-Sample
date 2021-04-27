//
//  CareKit_SampleApp.swift
//  CareKit Sample
//
//  Created by Santiago Gutierrez on 2/13/21.
//

import SwiftUI
import Firebase
import FirebaseAuth

@main
struct CareKit_SampleApp: App {
    
    init() {
        
        // Configure our Firebase instance & sign-in anonymously
        // Your application must have a valid GoogleService-Info.plist config file from Firebase.
        // NOTE: you must enable anonymous auth by:
        //  (1) open https://console.firebase.google.com/
        //  (2) open the Auth section
        //  (3) On the Sign-in Methods page, enable the Anonymous sign-in method.
        
         FirebaseApp.configure()
         Auth.auth().signInAnonymously()
    }
    
    var body: some Scene {
        WindowGroup {
            LaunchUIView()
        }
    }
}
