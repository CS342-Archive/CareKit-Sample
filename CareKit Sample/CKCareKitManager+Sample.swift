//
//  CKCareKitManager+Sample.swift
//  CardinalKit_Example
//
//  Created by Santiago Gutierrez on 12/21/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import CareKit
import CareKitStore
import Contacts
import UIKit

internal extension OCKStore {

    // Adds tasks and contacts into the store
    func populateSampleData() {
        seedLiveLectureTasks()
        seedResearchKitSample()
        seedSkinAI()
        createContacts()
    }
    
    func createContacts() {
        var contact1 = OCKContact(id: "oliver", givenName: "Oliver",
                                  familyName: "Aalami", carePlanUUID: nil)
        contact1.asset = "OliverAalami"
        contact1.title = "Vascular Surgeon"
        contact1.role = "Dr. Aalami is the director of the CardinalKit project."
        contact1.emailAddresses = [OCKLabeledValue(label: CNLabelEmailiCloud, value: "aalami@stanford.edu")]
        contact1.phoneNumbers = [OCKLabeledValue(label: CNLabelWork, value: "(111) 111-1111")]
        contact1.messagingNumbers = [OCKLabeledValue(label: CNLabelWork, value: "(111) 111-1111")]

        contact1.address = {
            let address = OCKPostalAddress()
            address.street = "318 Campus Drive"
            address.city = "Stanford"
            address.state = "CA"
            address.postalCode = "94305"
            return address
        }()

        addContacts([contact1])
    }
    
}

internal extension OCKStore {
    
    fileprivate func seedLiveLectureTasks() {
        
        // Rehab task
        // Week 1 - twice daily
        // Week 2 - once daily
        // Week 3 - end
        let startOfWeek1 = Calendar.current.startOfDay(for: Date())
        let endOfWeek1 = Calendar.current.date(byAdding: .weekOfYear, value: 1, to: startOfWeek1)!

        let week1Morning = OCKSchedule.dailyAtTime(hour: 8, minutes: 0, start: startOfWeek1, end: endOfWeek1, text: "Morning")
        
        let week1Evening = OCKSchedule.dailyAtTime(hour: 20, minutes: 0, start: startOfWeek1, end: endOfWeek1, text: "Before Bed")
        
        let rehabSchedule = OCKSchedule(composing: [week1Morning, week1Evening])
        
        var rehab = OCKTask(id: "rehab", title: "Skincare routine", carePlanUUID: nil, schedule: rehabSchedule)
        
        rehab.instructions = """
        Don't forget to follow your morning and evening skincare routine steps!
        """
        
        addTasks([rehab], callbackQueue: .main) { result in
            switch result {
            case let .success(tasks):
                print("Added \(tasks.count) tasks")
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
    
    fileprivate func seedResearchKitSample() {
        let surveySchedule = OCKSchedule.dailyAtTime(hour: 12, minutes: 0, start: Date(), end: nil, text: nil)
        var survey = OCKTask(id: "survey", title: "Take your skin survey", carePlanUUID: nil, schedule: surveySchedule)
        survey.impactsAdherence = true
        survey.instructions = "Please take your skin survey so we can know how you are doing."
        
        addTasks([survey], callbackQueue: .main, completion: nil)
    }
    
    fileprivate func seedSkinAI() {
        let skinAISchedule = OCKSchedule.dailyAtTime(hour: 12, minutes: 0, start: Date(), end: nil, text: nil)
        var skinAI = OCKTask(id: "skinAI", title: "Take your skin diagnosis", carePlanUUID: nil, schedule: skinAISchedule)
        skinAI.impactsAdherence = true
        skinAI.instructions = "Please take your skin diagnosis so we can monitor you skin progession."
        
        addTasks([skinAI], callbackQueue: .main, completion: nil)
    }
}
