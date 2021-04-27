//
//  CoffeeChartDataSource.swift
//  CardinalKit_Example
//
//  Created for the CardinalKit Framework.
//  Copyright © 2019 Stanford University. All rights reserved.
//
import Foundation
import ResearchKit


//class LineGraphChartDataSource: NSObject, ORKValueRangeGraphChartViewDataSource {
////    var plotPoints = [Int]()
//    var plotPoints = [
//        [
//            ORKValueRange(value: 200),
//            ORKValueRange(value: 450),
//            ORKValueRange(value: 500),
//            ORKValueRange(value: 250),
//            ORKValueRange(value: 300),
//            ORKValueRange(value: 600),
//            ORKValueRange(value: 300),
//        ],
//        [
//            ORKValueRange(value: 100),
//            ORKValueRange(value: 350),
//            ORKValueRange(value: 400),
//            ORKValueRange(value: 150),
//            ORKValueRange(value: 200),
//            ORKValueRange(value: 500),
//            ORKValueRange(value: 400),
//        ]
//    ]
//
//    override init() {
//        if let arr = (UserDefaults.standard.array(forKey: "user_default_array") ?? []) as? [Int] {
////            self.plotPoints = arr
//        }
//        super.init()
//    }
//
//    func numberOfPlots(in graphChartView: ORKGraphChartView) -> Int {
//        return 1
//    }
//
//    func graphChartView(_ graphChartView: ORKGraphChartView, dataPointForPointIndex pointIndex: Int, plotIndex: Int) -> ORKValueRange {
//        print(Double(plotPoints[pointIndex]))
//        return ORKValueRange(value: Double(plotPoints[pointIndex]))
//    }
//
//    func graphChartView(_ graphChartView: ORKGraphChartView, numberOfDataPointsForPlotIndex plotIndex: Int) -> Int {
//        graphChartView.noDataText = plotPoints.count == 0 ? "No Data" : ""
//        return plotPoints.count
//    }
//
//    func maximumValue(for graphChartView: ORKGraphChartView) -> Double {
//        return Double(plotPoints.max() ?? 0)
//    }
//
//    func minimumValue(for graphChartView: ORKGraphChartView) -> Double {
//        return 0
//    }
//
//    func graphChartView(_ graphChartView: ORKGraphChartView, titleForXAxisAtPointIndex pointIndex: Int) -> String? {
//        return String(self.plotPoints[pointIndex])
//    }
//
//    // MARK: - Convenience
////
////    func pointsAvg() -> Double {
////        if plotPoints.count > 0 {
////            return plotPoints.reduce(0) {$0 + $1} / Double(plotPoints.count)
////        }
////        return 0
////    }
//
//}

class LineGraphChartDataSource: NSObject, ORKValueRangeGraphChartViewDataSource {
    // MARK: Properties
    
    var plotPoints =
    [
        [
            ORKValueRange(value: 10),
            ORKValueRange(value: 20),
            ORKValueRange(value: 25),
            ORKValueRange(),
            ORKValueRange(value: 30),
            ORKValueRange(value: 40)
        ],
        [
            ORKValueRange(value: 2),
            ORKValueRange(value: 4),
            ORKValueRange(value: 8),
            ORKValueRange(value: 16),
            ORKValueRange(value: 32),
            ORKValueRange(value: 64)
        ]
    ]
    
    // MARK: ORKGraphChartViewDataSource
    
    func numberOfPlots(in graphChartView: ORKGraphChartView) -> Int {
        return plotPoints.count
    }
    
    func graphChartView(_ graphChartView: ORKGraphChartView, dataPointForPointIndex pointIndex: Int, plotIndex: Int) -> ORKValueRange {
        return plotPoints[plotIndex][pointIndex]
    }
    
    func graphChartView(_ graphChartView: ORKGraphChartView, numberOfDataPointsForPlotIndex plotIndex: Int) -> Int {
        return plotPoints[plotIndex].count
    }
    
    func maximumValue(for graphChartView: ORKGraphChartView) -> Double {
        return 70
    }
    
    func minimumValue(for graphChartView: ORKGraphChartView) -> Double {
        return 0
    }
    
    func graphChartView(_ graphChartView: ORKGraphChartView, titleForXAxisAtPointIndex pointIndex: Int) -> String? {
        return "\(pointIndex + 1)"
    }
}
