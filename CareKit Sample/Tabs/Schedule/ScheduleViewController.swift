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
        
    
        // Rehab
        let rehabViewController = OCKGridTaskViewController(taskID: "rehab", eventQuery: OCKEventQuery(for: date), storeManager: storeManager)
        listViewController.appendViewController(rehabViewController, animated: true)
        
        // Survey
        let surveyCard = SurveyItemViewController(
            viewSynchronizer: SurveyItemViewSynchronizer(),
            taskID: "survey",
            eventQuery: .init(for: date),
            storeManager: self.storeManager)
        listViewController.appendViewController(surveyCard, animated: true)
        
        // SkinAI
        let skinAIViewController = AcneModelViewController(
            viewSynchronizer: SkinAIViewSynchronizer(),
            taskID: "skinAI",
            eventQuery: .init(for: date),
            storeManager: self.storeManager)
        listViewController.appendViewController(skinAIViewController, animated: true)
        
        super.dailyPageViewController(dailyPageViewController, prepare: listViewController, for: date)
    }
}

private extension View {
    func formattedHostingController() -> UIHostingController<Self> {
        let viewController = UIHostingController(rootView: self)
        viewController.view.backgroundColor = .clear
        return viewController
    }
}

