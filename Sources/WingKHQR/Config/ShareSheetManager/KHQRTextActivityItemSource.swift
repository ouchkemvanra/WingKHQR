//
//  KHQRTextActivityItemSource.swift
//  WingKHQRTest
//
//  Created by Ouch Kemvanra on 2/14/24.
//

import UIKit
import LinkPresentation
class KHQRTextActivityItemSource: NSObject, UIActivityItemSource {
  
  let title: String
  private let logoIcon: UIImage
  private let content: String
  private let placeHolder: UIImage?
  
  init(title: String, content: String, placeHolder: UIImage? = nil, logoIcon: UIImage) {
    self.title = title
    self.content = content
    self.placeHolder = placeHolder
    self.logoIcon = logoIcon
    super.init()
  }
  
  func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
    return content
  }
  
  func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivity.ActivityType?) -> Any? {
    return content
  }
  
  @available(iOS 13.0, *)
  func activityViewControllerLinkMetadata(_ activityViewController: UIActivityViewController) -> LPLinkMetadata? {
    let metaData = LPLinkMetadata()
    metaData.title = title
    if let placeHolder = placeHolder {
      metaData.iconProvider = NSItemProvider(object: placeHolder.adjustedForShareSheetPreviewIconProvider())
      metaData.imageProvider = NSItemProvider(object: placeHolder.adjustedForShareSheetPreviewIconProvider())
    } else {
      let image = logoIcon.adjustedForShareSheetPreviewIconProvider()
      metaData.iconProvider = NSItemProvider(object: image)
      metaData.imageProvider = NSItemProvider(object: image)
    }
    return metaData
  }
}
