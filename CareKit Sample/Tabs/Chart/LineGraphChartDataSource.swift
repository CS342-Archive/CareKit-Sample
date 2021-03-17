//
//  CoffeeChartDataSource.swift
//  CardinalKit_Example
//
//  Created for the CardinalKit Framework.
//  Copyright © 2019 Stanford University. All rights reserved.
//

//import ResearchKit
//
//extension Sequence where Element: Hashable {
//    var histogram: [Element: Int] {
//        return self.reduce(into: [:]) { counts, elem in counts[elem, default: 0] += 1 }
//    }
//}
//
//class CoffeeChartDataSource: NSObject, ORKPieChartViewDataSource {
//
//    var countPerAnswer = [NSNumber: CGFloat]()
//    var keys = [NSNumber]()
//
//    override init() {
//        let arr = (UserDefaults.standard.array(forKey: "user_default_array") ?? []) as [Int]
//        let counts = arr.histogram
//
//        self.countPerAnswer = [NSNumber: CGFloat]()
//        self.countPerAnswer[0] = 0.0
//        self.countPerAnswer[1] = 0.0
//        self.countPerAnswer[3] = 0.0
//        self.countPerAnswer[4] = 0.0
//        self.keys = Array(countPerAnswer.keys)
//        super.init()
//    }
//
//    func numberOfSegments(in pieChartView: ORKPieChartView) -> Int {
//        return keys.count
//    }
//
//    func pieChartView(_ pieChartView: ORKPieChartView, valueForSegmentAt index: Int) -> CGFloat {
//        let key = keys[index]
//        return countPerAnswer[key] ?? 0.0
//    }
//
//    func pieChartView(_ pieChartView: ORKPieChartView, titleForSegmentAt index: Int) -> String? {
//        let answer = keys[index]
//        return "☕️ \(answer)"
//    }

//}
import Foundation
import ResearchKit


class LineGraphChartDataSource: NSObject, ORKValueRangeGraphChartViewDataSource {
//    var plotPoints = [Int]()
    var plotPoints = [1,2,3,4,5,6,7]
    
    override init() {
        if let arr = (UserDefaults.standard.array(forKey: "user_default_array") ?? []) as? [Int] {
//            self.plotPoints = arr
        }
        super.init()
    }
    
    func numberOfPlots(in graphChartView: ORKGraphChartView) -> Int {
        return 1
    }
    
    func graphChartView(_ graphChartView: ORKGraphChartView, dataPointForPointIndex pointIndex: Int, plotIndex: Int) -> ORKValueRange {
        print(Double(plotPoints[pointIndex]))
        return ORKValueRange(value: Double(plotPoints[pointIndex]))
    }

    func graphChartView(_ graphChartView: ORKGraphChartView, numberOfDataPointsForPlotIndex plotIndex: Int) -> Int {
        graphChartView.noDataText = plotPoints.count == 0 ? "No Data" : ""
        return plotPoints.count
    }

    func maximumValue(for graphChartView: ORKGraphChartView) -> Double {
        return Double(plotPoints.max() ?? 0)
    }

    func minimumValue(for graphChartView: ORKGraphChartView) -> Double {
        return 0
    }

    func graphChartView(_ graphChartView: ORKGraphChartView, titleForXAxisAtPointIndex pointIndex: Int) -> String? {
        return String(self.plotPoints[pointIndex])
    }

    // MARK: - Convenience
//
//    func pointsAvg() -> Double {
//        if plotPoints.count > 0 {
//            return plotPoints.reduce(0) {$0 + $1} / Double(plotPoints.count)
//        }
//        return 0
//    }

}


