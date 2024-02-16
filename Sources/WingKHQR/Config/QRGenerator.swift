//
//  QRGenerator.swift
//  WingKHQRTest
//
//  Created by Ouch Kemvanra on 2/14/24.
//

import AVFoundation
import UIKit

final class QRGenerator {
  static let shared = QRGenerator()
  
  private init() {}
  
  func generateQRCode(from string: String, scale: CGAffineTransform =  CGAffineTransform(scaleX: 5, y: 5)) -> UIImage {
    let data = string.data(using: .utf8)
    
    if let filter = CIFilter(name: "CIQRCodeGenerator") {
      filter.setValue(data, forKey: "inputMessage")
      filter.setValue("H", forKey: "inputCorrectionLevel")
      let transform = scale
      
      if let output = filter.outputImage?.transformed(by: transform) {
        // apply transparent background
        let colorParameters = [
          "inputColor0": CIColor(color: UIColor.black), // Foreground
          "inputColor1": CIColor(color: UIColor.clear) // Background
        ]
        let ciImage = output.applyingFilter("CIFalseColor", parameters: colorParameters)
        let context = CIContext()
        if let ciContextImage = context.createCGImage(ciImage, from: output.extent) {
          return UIImage(cgImage: ciContextImage)
        } else {
          return UIImage(ciImage: ciImage)
        }
      }
    }
    
    // Prevent crash
    return UIImage()
  }
  
  func renderQRCodeImage(from view: UIView) -> UIImage? {
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 0.0)
    view.drawHierarchy(in: view.bounds, afterScreenUpdates: false)
    let renderView = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return renderView
  }
}
