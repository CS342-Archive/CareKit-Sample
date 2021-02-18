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
        
        // Meds
        let medsViewController = OCKGridTaskViewController(taskID: "meds", eventQuery: OCKEventQuery(for: date), storeManager: storeManager)
        listViewController.appendViewController(medsViewController, animated: true)
        
        // Rehab
        let rehabViewController = OCKGridTaskViewController(taskID: "rehab", eventQuery: OCKEventQuery(for: date), storeManager: storeManager)
        listViewController.appendViewController(rehabViewController, animated: true)
        
        // Charts
        let rehabConfig = OCKDataSeriesConfiguration(taskID: "rehab", legendTitle: "Rehab", gradientStartColor: .systemGray, gradientEndColor: .systemGray, markerSize: 6, eventAggregator: .countOutcomeValues)
        let rehabCharts = OCKCartesianChartViewController(plotType: .bar, selectedDate: date, configurations: [rehabConfig], storeManager: storeManager)
        listViewController.appendViewController(rehabCharts, animated: true)
        
        // Survey
        let surveyCard = SurveyItemViewController(
            viewSynchronizer: SurveyItemViewSynchronizer(),
            taskID: "survey",
            eventQuery: .init(for: date),
            storeManager: self.storeManager)
        listViewController.appendViewController(surveyCard, animated: true)
        
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
