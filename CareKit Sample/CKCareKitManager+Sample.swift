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
        
        // Daily medication task
        let medsSchedule = OCKSchedule.dailyAtTime(hour: 8, minutes: 0, start: Date(), end: nil, text: nil)
        var meds = OCKTask(id: "meds", title: "Take your accutane", carePlanUUID: nil, schedule: medsSchedule)
        meds.instructions = "Take 1 tablet after breakfast."
        
        // Rehab task
        // Week 1 - twice daily
        // Week 2 - once daily
        // Week 3 - end
        let startOfWeek1 = Calendar.current.startOfDay(for: Date())
        let endOfWeek1 = Calendar.current.date(byAdding: .weekOfYear, value: 1, to: startOfWeek1)!
        let startOfWeek2 = endOfWeek1
        let endOfWeek2 = Calendar.current.date(byAdding: .weekOfYear, value: 1, to: startOfWeek2)!
        
        let week1Morning = OCKSchedule.dailyAtTime(hour: 8, minutes: 0, start: startOfWeek1, end: endOfWeek1, text: "Morning")
        
        let week1Evening = OCKSchedule.dailyAtTime(hour: 20, minutes: 0, start: startOfWeek1, end: endOfWeek1, text: "Before Bed")
        
        let week2Afternoon = OCKSchedule.dailyAtTime(hour: 12, minutes: 0, start: startOfWeek2, end: endOfWeek2, text: "Afternoon")
        
        let rehabSchedule = OCKSchedule(composing: [week1Morning, week1Evening, week2Afternoon])
        
        var rehab = OCKTask(id: "rehab", title: "Rehab Exercises", carePlanUUID: nil, schedule: rehabSchedule)
        
        rehab.instructions = """
        Lie on your back and bend your affected knee 90 degrees with your foot.
        You can modify this text with any instructions of your choice!
        """
        
        /**
         * This is not an intended feature of CareKit out of the box, but it lets us group medications.
         * Please study this implementation thoroughly before using it out of the box.
         */
        let groupedMedications = ["Acetaminophen", "Adderall", "Amitriptyline", "Amlodipine", "Amoxicillin"]
        var scheduleItems = [OCKSchedule]()
        for med in groupedMedications {
            scheduleItems.append(OCKSchedule.dailyAtTime(hour: 8, minutes: 0, start: startOfWeek1, end: endOfWeek1, text: med))
        }
        let groupedSchedule = OCKSchedule(composing: scheduleItems)
        let groupedInstruction = "This task is for \(scheduleItems.count) medication(s)"
        
        var morningGroup = OCKTask(id: "morning-group", title: "Morning Pills", carePlanUUID: nil, schedule: groupedSchedule)
        morningGroup.instructions = groupedInstruction
        
        
        addTasks([meds, rehab, morningGroup], callbackQueue: .main) { result in
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
        var survey = OCKTask(id: "survey", title: "Take a Survey 📝", carePlanUUID: nil, schedule: surveySchedule)
        survey.impactsAdherence = true
        survey.instructions = "You can schedule any ResearchKit survey in your app."
        
        addTasks([survey], callbackQueue: .main, completion: nil)
    }
    
}
