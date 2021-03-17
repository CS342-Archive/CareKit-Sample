//
//  ScheduleViewController.swift
//  CardinalKit_Example
//
//  Created by Santiago Gutierrez on 12/21/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import CareKit
import CareKitStore
import UIKit
import SwiftUI



class ScheduleViewController: OCKDailyPageViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Schedule"
    }
    
    override func dailyPageViewController(_ dailyPageViewController: OCKDailyPageViewController, prepare listViewController: OCKListViewController, for date: Date) {
        
        let identifiers = ["skinAI", "survey", "rehab"]
        var query = OCKTaskQuery(for: date)
        query.ids = identifiers
        query.excludesTasksWithNoEvents = true

        storeManager.store.fetchAnyTasks(query: query, callbackQueue: .main) { result in
            switch result {
            case .failure(let error): print("Error: \(error)")
            case .success(let tasks):
                
                // Routine
                if let task = tasks.first(where: { $0.id == "rehab" }) {
                    let rehabViewController = OCKGridTaskViewController(task: task, eventQuery: OCKEventQuery(for: date), storeManager: self.storeManager)
                    listViewController.appendViewController(rehabViewController, animated: true)
                }
                
                // Skin diagnosis
                if let task = tasks.first(where: { $0.id == "skinAI" }) {
                    let skinAIViewController = AcneModelViewController(
                            viewSynchronizer: SkinAIViewSynchronizer(),
                            task: task,
                            eventQuery: .init(for: date),
                            storeManager: self.storeManager)
                    listViewController.appendViewController(skinAIViewController, animated: true)
                }
                
                // Survey
                if let task = tasks.first(where: { $0.id == "survey" }) {
                    let surveyCard = SurveyItemViewController(
                        viewSynchronizer: SurveyItemViewSynchronizer(),
                        task: task,
                        eventQuery: .init(for: date),
                        storeManager: self.storeManager)
                    listViewController.appendViewController(surveyCard, animated: true)
                }
            }
        }
//        super.dailyPageViewController(dailyPageViewController, prepare: listViewController, for: date)
    }
}

private extension View {
    func formattedHostingController() -> UIHostingController<Self> {
        let viewController = UIHostingController(rootView: self)
        viewController.view.backgroundColor = .clear
        return viewController
    }
}

