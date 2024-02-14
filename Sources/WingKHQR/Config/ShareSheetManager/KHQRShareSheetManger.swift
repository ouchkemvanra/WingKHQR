//
//  KHQRShareSheetManger.swift
//  WingKHQRTest
//
//  Created by Ouch Kemvanra on 2/14/24.
//

import UIKit
import LinkPresentation

final class ShareSheetManager {
  
  static let shared = ShareSheetManager()
  
  private init() {}
  
  func showShareSheet(_ image: UIImage, title: String , from vc: UIViewController, saveImageSuccess: KHQRCallback? = nil, logoIcon: UIImage){
    let activityVC = RevampKHQRActivityViewController(activityItems: [OptionalTextActivityItemSource(text: title), KHQRImageActivityItemSource.init(title: title, image: image, isKHQR: true, logoIcon: logoIcon)], applicationActivities: nil)
      
      activityVC.completionWithItemsHandler = { (activityType, completed:Bool, returnedItems:[Any]?, error: Error?) in
        //MARK: - If activity was cancelled
        if !completed{
          DispatchQueue.main.async{
            vc.dismiss(animated: true, completion: nil)
            return
          }
        }
        // MARK: - If completed activity dismiss Screenshot view first then if activity type is save to camera show success alert
        vc.dismiss(animated: true){
          if activityType == .saveToCameraRoll && completed{ // Photo Save Successfully
            // MARK: - Alert Save Success
            saveImageSuccess?()
          }
        }
      }
      vc.present(activityVC, animated: true, completion: nil)
  }
}
