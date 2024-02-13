//
//  Extension.swift
//  WingKHQRTest
//
//  Created by Ouch Kemvanra on 2/6/24.
//

import UIKit

extension UIFont {
  var bold: UIFont {
    return with(traits: .traitBold)
  }
  
  var italic: UIFont {
    return with(traits: .traitItalic)
  }
  
  var boldItalic: UIFont {
    return with(traits: [.traitBold, .traitItalic])
  }
  
  func with(traits: UIFontDescriptor.SymbolicTraits) -> UIFont {
    guard let descriptor = self.fontDescriptor.withSymbolicTraits(traits) else {
      return self
    }
    return UIFont(descriptor: descriptor, size: 0)
  }
  
  var rounded: UIFont {
    if #available(iOS 13.0, *), let descriptor = fontDescriptor.withDesign(.rounded) {
      return UIFont(descriptor: descriptor, size: pointSize)
    } else {
      return self
    }
  }
}

extension UIColor{
  convenience init(hex: String) {
    var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
    hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

    var rgb: UInt64 = 0

    var r: CGFloat = 0.0
    var g: CGFloat = 0.0
    var b: CGFloat = 0.0
    var a: CGFloat = 1.0

    let length = hexSanitized.count
    self.init(red: 1, green: 1, blue: 1, alpha: 1)
    guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else {
      self.init(red: 1, green: 1, blue: 1, alpha: 1)
      return
    }

    if length == 6 {
      r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
      g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
      b = CGFloat(rgb & 0x0000FF) / 255.0

    } else if length == 8 {
      r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
      g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
      b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
      a = CGFloat(rgb & 0x000000FF) / 255.0

    } else {
      self.init(red: 1, green: 1, blue: 1, alpha: 1)
      return
    }

    self.init(red: r, green: g, blue: b, alpha: a)
  }
}
extension UILabel{
  func setAmountKHQR(amount: String, currency: String){
    let amountAtt = NSMutableAttributedString.init(string: amount, attributes: [.foregroundColor: KHQRConfig.khqrDarkText, .font: KHQRFont.size(24, weight: .bold)])
    let currencyAtt = NSMutableAttributedString.init(string: currency, attributes: [.foregroundColor: KHQRConfig.khqrDarkText, .font: KHQRFont.size(12)])
    amountAtt.append(currencyAtt)
    self.attributedText = amountAtt
  }
}
