//
//  KHQRAccount.swift
//  WingKHQRTest
//
//  Created by Ouch Kemvanra on 2/13/24.
//

import UIKit

open class KHQRAccount{
  public var name: String
  public var accountNumber: String
  public var qr: String
  public var amount: String
  public var currency: String
  public var currencyImage: UIImage?
  
  public init(name: String, amount: String, currency: String, accountNumber: String, qr: String, currencyImage: UIImage? = nil) {
    self.name = name
    self.amount = amount
    self.currency = currency
    self.accountNumber = accountNumber
    self.qr = qr
    self.currencyImage = currencyImage
  }
}
