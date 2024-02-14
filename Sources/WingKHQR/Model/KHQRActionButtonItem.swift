//
//  KHQRActionButtonItem.swift
//  WingKHQRTest
//
//  Created by Ouch Kemvanra on 2/13/24.
//

import UIKit
final class KHQRActionButtonItem{
  var type: KHQRActionButtonType
  var title: String
  var icon: UIImage?
  
  init(type: KHQRActionButtonType, title: String, icon: UIImage?) {
    self.type = type
    self.title = title
    self.icon = icon
  }
}
