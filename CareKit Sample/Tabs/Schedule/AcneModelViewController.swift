//
// SkinAIViewController.swift
// CareKit Sample
//
// Created by Ines Chami on 3/1/21.
//
import UIKit
import Vision
import CoreML
import ResearchKit
import Foundation
import CareKit
import CareKitUI
import CareKitStore

class AcneModelViewController: OCKInstructionsTaskViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate, ORKTaskViewControllerDelegate {
  var image: UIImage!
  var acneLevel: String = ""
  // 2. This method is called when the use taps the button!
  override func taskView(_ taskView: UIView & OCKTaskDisplayable, didCompleteEvent isComplete: Bool, at indexPath: IndexPath, sender: Any?) {
    // Do any additional setup after loading the view.
    let vc = UIImagePickerController()
    vc.sourceType = .camera
    vc.allowsEditing = true
    vc.delegate = self
    present(vc, animated: true)
  }
  /*
  // MARK: - Navigation
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // Get the new view controller using segue.destination.
    // Pass the selected object to the new view controller.
  }
  */
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    picker.dismiss(animated: true)
    guard let image = info[.editedImage] as? UIImage else {
      print("No image found")
      return
    }
    // print out the image size as a test
    print(image.size)
    self.image = image
    detectImageContent()
  }
  func detectImageContent() {
    guard let model = try? VNCoreMLModel(for: acne_classification().model) else {
     fatalError("Failed to load model")
    }
    // Create a vision request
    let request = VNCoreMLRequest(model: model) {[weak self] request, error in
     guard let results = request.results as? [VNClassificationObservation],
      let topResult = results.first
      else {
       fatalError("Unexpected results")
     }
    // UserDefaults.standard.set(topResult.identifier, forKey: "acneLevel")
    self?.acneLevel = topResult.identifier
    var prediction_int = Int()
    // Update the Main UI Thread with our result
     DispatchQueue.main.async { [weak self] in
    print("acne level: \(String(describing: self?.acneLevel))")
      var user_default_array = [Int]()
      if UserDefaults.standard.array(forKey: "user_default_array") == nil {
        UserDefaults.standard.setValue(user_default_array, forKey: "user_default_array")
      }
      if String(describing: self!.acneLevel) == "mild" {
        prediction_int = 1
        user_default_array.append(prediction_int)
        var user_array = UserDefaults.standard.array(forKey: "user_default_array")
        user_array?.append(prediction_int)
        UserDefaults.standard.setValue(user_array, forKey: "user_default_array")
        }
      if String(describing: self!.acneLevel) == "moderate" {
        prediction_int = 2
        user_default_array.append(prediction_int)
        var user_array = UserDefaults.standard.array(forKey: "user_default_array")
        user_array?.append(prediction_int)
        UserDefaults.standard.setValue(user_array, forKey: "user_default_array")
      }
      if String(describing: self!.acneLevel) == "severe" {
        prediction_int = 3
        user_default_array.append(prediction_int)
        var user_array = UserDefaults.standard.array(forKey: "user_default_array")
        user_array?.append(prediction_int)
        UserDefaults.standard.setValue(user_array, forKey: "user_default_array")
      }
      if String(describing: self!.acneLevel) == "very severe" {
        prediction_int = 4
        user_default_array.append(prediction_int)
        var user_array = UserDefaults.standard.array(forKey: "user_default_array")
        user_array?.append(prediction_int)
        UserDefaults.standard.setValue(user_array, forKey: "user_default_array")
      }
      let alert = UIAlertController(title: "Results", message: String(describing: self!.acneLevel), preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
         switch action.style{
         case .default:
            print("default")
         case .cancel:
            print("cancel")
         case .destructive:
            print("destructive")
      }}))
      self?.present(alert, animated: true, completion: nil)
//      DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//       // Show result on screen here using identifier
//        print("\(topResult.identifier) with \(Int(topResult.confidence * 100))% confidence")
//      }
     }
    }
    guard let ciImage = CIImage(image: self.image!)
     else { fatalError("Cant create CIImage from UIImage") }
    let handler = VNImageRequestHandler(ciImage: ciImage)
    DispatchQueue.global().async {
     do {
      try handler.perform([request])
     } catch {
      print(error)
     }
    }
   }
  func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
    taskViewController.dismiss(animated: true, completion: nil)
    guard reason == .completed else {
      taskView.completionButton.isSelected = false
      return
    }
    // 4a. Retrieve the result from the ResearchKit survey
//    if let savedData = UserDefaults.standard.string(forKey: "acneLevel") {
//      self.acneLevel = savedData
//    }
    // 4b. Save the result into CareKit's store
    controller.appendOutcomeValue(value: self.acneLevel, at: IndexPath(item: 0, section: 0), completion: nil)
    let gcpDelegate = CKUploadToGCPTaskViewControllerDelegate()
    gcpDelegate.taskViewController(taskViewController, didFinishWith: reason, error: error)
  }
}
class SkinAIViewSynchronizer: OCKInstructionsTaskViewSynchronizer {
  // Customize the initial state of the view
  override func makeView() -> OCKInstructionsTaskView {
    let instructionsView = super.makeView()
    instructionsView.completionButton.label.text = "Start"
    return instructionsView
  }
  override func updateView(_ view: OCKInstructionsTaskView, context: OCKSynchronizationContext<OCKTaskEvents>) {
    super.updateView(view, context: context)
    // Check if an answer exists or not and set the detail label accordingly
    let element: [OCKAnyEvent]? = context.viewModel.first
    let firstEvent = element?.first
    view.headerView.titleLabel.text = "Skin Diagnosis"
    if let acneLevel = firstEvent?.outcome?.values.first {
      view.headerView.detailLabel.text = "Thank you for completing your skin diagnosis."
    } else {
      view.headerView.detailLabel.text = "Please take your skin diagnosis so we can monitor you skin progession."
    }
  }
}
