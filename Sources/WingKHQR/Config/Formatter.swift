//
//  Formatter.swift
//  WingKHQRTest
//
//  Created by Ouch Kemvanra on 2/19/24.
//

import Foundation
final class Formatter {
  private static var shared = Formatter()
  private init() {}
  
  static var currencyFormatter: NumberFormatter { shared._currencyFormatter }
  static var khrCurrencyFormatter: NumberFormatter { shared._khrCurrencyFormatter }
  
  private lazy var _currencyFormatter : NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.groupingSeparator = ","
    formatter.groupingSize = 3
    formatter.usesGroupingSeparator = true
    formatter.decimalSeparator = "."
    formatter.numberStyle = .decimal
    formatter.maximumFractionDigits = 2
    formatter.minimumFractionDigits = 2
    formatter.locale = Locale(identifier: "en_US")
    return formatter
  }()
  
  private lazy var _khrCurrencyFormatter : NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.groupingSeparator = ","
    formatter.groupingSize = 3
    formatter.usesGroupingSeparator = true
    formatter.decimalSeparator = "."
    formatter.numberStyle = .decimal
    formatter.maximumFractionDigits = 0
    formatter.minimumFractionDigits = 0
    formatter.locale = Locale(identifier: "en_US")
    return formatter
  }()
}
