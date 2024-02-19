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
extension UIImage {
 func adjustedForShareSheetPreviewIconProvider() -> UIImage {
   let replaceTransparencyWithColor = UIColor.white // change as required
   let minimumSize: CGFloat = 40.0  // points
   
   let format = UIGraphicsImageRendererFormat.init()
   format.opaque = true
   format.scale = self.scale
   
   let imageWidth = self.size.width
   let imageHeight = self.size.height
   let imageSmallestDimension = max(imageWidth, imageHeight)
   let deviceScale = UIScreen.main.scale
   let resizeFactor = minimumSize * deviceScale  / (imageSmallestDimension * self.scale)
   
   let size = resizeFactor > 1.0
     ? CGSize(width: imageWidth * resizeFactor, height: imageHeight * resizeFactor)
     : self.size
   
   return UIGraphicsImageRenderer(size: size, format: format).image { context in
     let size = context.format.bounds.size
     replaceTransparencyWithColor.setFill()
     context.fill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
     self.draw(in: CGRect(origin: .zero, size: size))
   }
 }
}

extension UIViewController{
  final func presentModal(_ viewControllerToPresent: UIViewController,
                          animated: Bool = true,
                          completion: (() -> Void)? = nil) {
    viewControllerToPresent.modalPresentationStyle = .overFullScreen//.overCurrentContext
    viewControllerToPresent.modalTransitionStyle = .crossDissolve
    viewControllerToPresent.modalPresentationCapturesStatusBarAppearance = true
    (tabBarController ?? self).present(viewControllerToPresent, animated: animated, completion: completion)
  }
}

extension UIView {
    /// Creates an image from the view's contents, using its layer.
    ///
    /// - Returns: An image, or nil if an image couldn't be created.
    func image() -> UIImage? {
      UIGraphicsBeginImageContextWithOptions(bounds.size, self.isOpaque, 0)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        context.saveGState()
        layer.render(in: context)
        context.restoreGState()
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return image
    }
}
extension Double {
  var currencyFormat: String {
    let symbol: String = self >= 0 ? "" : "-"
    return symbol + Formatter.currencyFormatter.string(from: abs(self) as NSNumber).orEmpty
  }
  
  var khCurrencyFormat: String {
    let symbol: String = self >= 0 ? "" : "-"
    return symbol + Formatter.khrCurrencyFormatter.string(from: abs(self) as NSNumber).orEmpty
  }
}
