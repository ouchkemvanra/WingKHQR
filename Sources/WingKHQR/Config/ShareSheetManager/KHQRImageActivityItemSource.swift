//
//  KHQRImageActivityItemSource.swift
//  WingKHQRTest
//
//  Created by Ouch Kemvanra on 2/14/24.
//

import UIKit
import LinkPresentation

final class KHQRImageActivityItemSource: NSObject, UIActivityItemSource {
  
  private let title: String
  private let image: UIImage
  private var isKHQR: Bool
  private var placeHolder: UIImage?
  private let logoIcon: UIImage
  
  init(title: String, image: UIImage, isKHQR: Bool = false, placeholder: UIImage? = nil, logoIcon: UIImage) {
    self.title = title
    self.image = image
    self.isKHQR = isKHQR
    self.placeHolder = placeholder
    self.logoIcon = logoIcon
    super.init()
  }
  
  func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
    return image
  }
  
  func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivity.ActivityType?) -> Any? {
      return image
  }
  
  @available(iOS 13.0, *)
  func activityViewControllerLinkMetadata(_ activityViewController: UIActivityViewController) -> LPLinkMetadata? {
    let metaData = LPLinkMetadata()
    metaData.title = title
    if let placeHolder = placeHolder {
      metaData.iconProvider = NSItemProvider(object: placeHolder.adjustedForShareSheetPreviewIconProvider())
      metaData.imageProvider = NSItemProvider(object: placeHolder.adjustedForShareSheetPreviewIconProvider())
    } else {
      let iconImg = logoIcon
      let image = iconImg.adjustedForShareSheetPreviewIconProvider()
      metaData.iconProvider = NSItemProvider(object: image)
      metaData.imageProvider = NSItemProvider(object: image)
    }
    return metaData
  }
}
