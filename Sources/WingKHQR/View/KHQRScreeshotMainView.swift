//
//  KHQRScreeshotMainView.swift
//  WingKHQRTest
//
//  Created by Ouch Kemvanra on 2/14/24.
//

import UIKit

final class KHQRScreeshotMainView: UIView{
  
  // MARK: - Layout
  private 
  lazy var qrView: KHQRView = {
    let view = KHQRView()
    
    return view
  }()
  
  // MARK: - Init
  init(){
    super.init(frame: .zero)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Prepare Layout
  private
  func prepareLayout(){
    
  }
}

extension KHQRScreeshotMainView{
  final func setQrImage(_ qr: UIImage?){
    qrView.setQrImage(qr)
  }
  
  final func setCurrencyImage(_ currency: UIImage?){
    qrView.setCurrencyImage(currency)
  }
  final func setkhqrLogo(_ logo: UIImage?){
    qrView.setKHQRLogo(logo)
  }
}
