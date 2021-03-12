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
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Print Outcomes", style: .plain, target: self, action: #selector(printOutcomes))
    }
    
    override func dailyPageViewController(_ dailyPageViewController: OCKDailyPageViewController, prepare listViewController: OCKListViewController, for date: Date) {
        
        // Meds
        let medsViewController = OCKGridTaskViewController(taskID: "meds", eventQuery: OCKEventQuery(for: date), storeManager: storeManager)
        listViewController.appendViewController(medsViewController, animated: true)
        
        // Rehab
        let rehabViewController = OCKGridTaskViewController(taskID: "rehab", eventQuery: OCKEventQuery(for: date), storeManager: storeManager)
        listViewController.appendViewController(rehabViewController, animated: true)
        
        // Morning Group
        let morningController = OCKChecklistTaskViewController(taskID: "morning-group", eventQuery: OCKEventQuery(for: date), storeManager: storeManager)
        listViewController.appendViewController(morningController, animated: true)
        
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

extension ScheduleViewController {
    
    @objc fileprivate func printOutcomes() {
        let query = OCKOutcomeQuery()
        storeManager.store.fetchAnyOutcomes(query: query, callbackQueue: .main) { (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let outcomes):
                for anyOutcome in outcomes {
                    let outcome = anyOutcome as! OCKOutcome
                    print("Outcome for task \(outcome.taskUUID) with index \(outcome.taskOccurrenceIndex) and value \(outcome.values)")
                    self.printTask(byId: outcome.taskUUID, withIndex: outcome.taskOccurrenceIndex)
                }
            }
        }
    
    }
    
    fileprivate func printTask(byId id: UUID, withIndex index: Int) {
        var query = OCKTaskQuery()
        query.uuids = [id]
        
        storeManager.store.fetchAnyTasks(query: query, callbackQueue: .main) { (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let tasks):
                for task in tasks {
                    print("------start task")
                    print(task.id)
                    print(task.title ?? "no title")
                    print(task.instructions ?? "no instructions")
                    print("scheduled:")
                    for (i, element) in task.schedule.elements.enumerated() {
                        print("\(index == i ? "[X]": "")" + "\t" + (element.text ?? ""))
                    }
                    print("------end task")
                }
            }
        }
        
    }
    
}

private extension View {
    func formattedHostingController() -> UIHostingController<Self> {
        let viewController = UIHostingController(rootView: self)
        viewController.view.backgroundColor = .clear
        return viewController
    }
}
