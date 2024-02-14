//
//  KHQRAccount.swift
//  WingKHQRTest
//
//  Created by Ouch Kemvanra on 2/13/24.
//

import Foundation

final class KHQRAccount{
  var name: String
  var amount: String
  var currency: String
  var accountNumber: String
  var qr: String
  
  init(name: String, amount: String, currency: String, accountNumber: String, qr: String) {
    self.name = name
    self.amount = amount
    self.currency = currency
    self.accountNumber = accountNumber
    self.qr = qr
  }
}