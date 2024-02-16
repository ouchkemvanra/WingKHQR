//
//  KHQRAccount.swift
//  WingKHQRTest
//
//  Created by Ouch Kemvanra on 2/13/24.
//

import UIKit

public class KHQRAccount{
  var name: String
  var amount: String
  var currency: String
  var accountNumber: String
  var qr: String
  
  var currencyImage: UIImage?
  
  public init(name: String, amount: String, currency: String, accountNumber: String, qr: String, currencyImage: UIImage? = nil) {
    self.name = name
    self.amount = amount
    self.currency = currency
    self.accountNumber = accountNumber
    self.qr = qr
    self.currencyImage = currencyImage
  }
}
