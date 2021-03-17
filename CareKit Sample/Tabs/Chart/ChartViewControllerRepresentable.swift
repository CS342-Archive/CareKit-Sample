//
//  ChartViewControllerRepresentable.swift
//  CareKit Sample
//
//  Created by Ines Chami on 3/16/21.
//

import Foundation
import SwiftUI
import UIKit
import CareKit

struct ChartViewControllerRepresentable: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = UIViewController
    
    func updateUIViewController(_ taskViewController: UIViewController, context: Context) {}
    func makeUIViewController(context: Context) -> UIViewController {

        let viewController = ChartViewController()
        viewController.title = "Charts"
        
        return UINavigationController(rootViewController: viewController)
    }
    
}
