//
//  KHQRTextUrlActivityItemSource.swift
//  WingKHQRTest
//
//  Created by Ouch Kemvanra on 2/14/24.
//

import UIKit
import LinkPresentation

final class KHQRTextUrlActivityItemSource: KHQRTextActivityItemSource{
  private let link: URL
  private let logoIcon: UIImage
  
  init(title: String, content: String, link: URL, logoIcon: UIImage){
    self.link = link
    self.logoIcon = logoIcon
    super.init(title: title, content: content, logoIcon: logoIcon)
  }
  
  @available(iOS 13.0, *)
  override func activityViewControllerLinkMetadata(_ activityViewController: UIActivityViewController) -> LPLinkMetadata? {
    let metaData = LPLinkMetadata()
    metaData.title = title
    metaData.originalURL = link
    let iconImg = logoIcon
    let image = iconImg.adjustedForShareSheetPreviewIconProvider()
    metaData.iconProvider = NSItemProvider(object: image)
    metaData.imageProvider = NSItemProvider(object: image)
    return metaData
  }
}
