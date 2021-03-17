//
//  CoffeePieChartView.swift
//  CardinalKit_Example
//
//  Created by Santiago Gutierrez on 2/17/21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import SwiftUI
import ResearchKit

struct LineGraphChartView : UIViewRepresentable {
    
    func makeUIView(context: Context) -> some UIView {
//        let config = Config.shared
//        let tintColor = config.readColor(query: "Tint Color")
        
//        let chartView = ORKPieChartView()
        let chartView = ORKLineGraphChartView()
        chartView.showsHorizontalReferenceLines = true
        chartView.showsVerticalReferenceLines = true
        
//        chartView.tintColor = tintColor
//        chartView.showsTitleAboveChart = true
//        chartView.title = "Skin progression"
//        chartView.text = "Here is you acne score plotted over time."
//        chartView.noDataText = "Take your skin diagnosis and come back!"
        
        let dataSource = LineGraphChartDataSource()
        chartView.dataSource = dataSource as ORKValueRangeGraphChartViewDataSource
        chartView.animate(withDuration: 1.0)
        
        return chartView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
}
