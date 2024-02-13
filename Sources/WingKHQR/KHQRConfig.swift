//
//  KHQRConfig.swift
//  WingKHQRTest
//
//  Created by Ouch Kemvanra on 2/6/24.
//

import UIKit

typealias KHQRCallback = (() -> Swift.Void)
typealias KHQRCallbackType<T> = ((T) -> Swift.Void)

class KHQRConfig{
  // KHQR
  static let khqrRedColor: UIColor = UIColor(hex: "#E21A1A")
  static let khqrTextBlue: UIColor = UIColor(hex: "#0077FF")
  static let khqrError: UIColor = UIColor(hex: "#EA3323")
  static let khqrDarkText: UIColor = UIColor(hex: "#1A1A1A")
  static let khqrAttentionBlue: UIColor = UIColor(hex: "#ECF4FF")
  static let khqrAttentionBlueText: UIColor = UIColor(hex: "#3F8EFC")
  static let khqrScreenshotBackgournd: UIColor = UIColor(hex: "#575757")
  // KHQR Screenshot
  static let khqrScreenshotTopView: UIColor = UIColor(hex: "#A9CB37")
  
  // Size Class
  static var sizeClass: SizeClass {
    switch min(UIScreen.main.bounds.width, UIScreen.main.bounds.height) {
    case let width where width <= 320:
      return .compact
      
    case let width where width >= 375 && width < 414:
      return .regular
      
    case let width where width >= 414 && width < 420:
      return .large
      
    default:
      return .extraLarge
    }
  }
  
  // Padding
  static let khqrCardHeight: CGFloat = {
    return ((UIScreen.main.bounds.width - (khqrViewPadding * 2)) * 29)/20
  }()
  static let khqrQRTopBottomPadding : CGFloat = {
    return khqrCardHeight * 0.08
  }()
  static let khqrQRLeftRightPadding : CGFloat = {
    return khqrCardHeight * 0.1
  }()
  static let khqrRedHeaderHeight: CGFloat = {
    return (khqrCardHeight * 0.12) + 25
  }()
  
  static let khqrViewPadding : CGFloat = {
    switch KHQRConfig.sizeClass {
    case .large,
        .extraLarge:
      return 40
      
    case .compact:
      return 70

    case .regular:
      return UIScreen.main.bounds.height < 812 ? 60 : 40
    }
  }()
  static let wingLogoHeight: CGFloat = {
    switch KHQRConfig.sizeClass {
    case.extraLarge:
      return 40
    case .large:
      return 40
    case .compact:
      return 30
    case .regular:
      return 40
    }
  }()
}

enum SizeClass {
  /// Represent small device (iPhone 5, 5s, SE first gen)
  case compact
  
  /// Represent standard device including iPhone SE 2nd gen, 6s, 7, 8, X, Xs, 11 Pro, 12 Pro, 13 Pro, 12 mini, 13, 13 mini
  case regular
  
  /// Represent plus device like iPhone 6 plus, 7 plus, 8 plus, XR, 11, 12
  case large
  
  /// Represent extra large device including iPhone XS Max, 11 Pro Max, 12 Pro Max, 13 Pro Max
  case extraLarge
}
