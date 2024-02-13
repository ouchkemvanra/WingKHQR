//
//  KHQRFont.swift
//  WingKHQRTest
//
//  Created by Ouch Kemvanra on 2/6/24.
//

import UIKit

final class KHQRFont {
  
  private init() {}
  
  class func size(_ size: CGFloat, weight: UIFont.Weight = .regular) -> UIFont {
    UIFont.systemFont(ofSize: size, weight: weight)
  }
  
  class func largeTitle(_ weight: UIFont.Weight = .regular) -> UIFont {
    UIFont.systemFont(ofSize: 34, weight: weight)
  }
  
  class func title1(_ weight: UIFont.Weight = .regular) -> UIFont {
    UIFont.systemFont(ofSize: 28, weight: weight)
  }
  
  class func title2(_ weight: UIFont.Weight = .regular) -> UIFont {
    UIFont.systemFont(ofSize: 22, weight: weight)
  }
  
  class func title3(_ weight: UIFont.Weight = .regular) -> UIFont {
    UIFont.systemFont(ofSize: 20, weight: weight)
  }
  
  class func body(_ weight: UIFont.Weight = .regular) -> UIFont {
    UIFont.systemFont(ofSize: 17, weight: weight)
  }
  
  class func callout(_ weight: UIFont.Weight = .regular) -> UIFont {
    UIFont.systemFont(ofSize: 16, weight: weight)
  }
  
  class func subheadline(_ weight: UIFont.Weight = .regular) -> UIFont {
    UIFont.systemFont(ofSize: 15, weight: weight)
  }
  
  class func footnote(_ weight: UIFont.Weight = .regular) -> UIFont {
    UIFont.systemFont(ofSize: 13, weight: weight)
  }
  
  class func caption1(_ weight: UIFont.Weight = .regular) -> UIFont {
    UIFont.systemFont(ofSize: 12, weight: weight)
  }
  
  class func caption2(_ weight: UIFont.Weight = .regular) -> UIFont {
    UIFont.systemFont(ofSize: 11, weight: weight)
  }
}
