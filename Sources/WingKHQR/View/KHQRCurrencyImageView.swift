//
//  KHQRCurrencyImageView.swift
//  WingKHQRTest
//
//  Created by Ouch Kemvanra on 2/12/24.
//

import UIKit

final class KHQRCurrencyImageView: UIView{
  private lazy var qrImageView: UIImageView = {
    let imv = UIImageView()
    imv.contentMode = .scaleAspectFit
    return imv
  }()
  
  private lazy var currencyImageView: UIImageView = {
    let imv = UIImageView()
    imv.contentMode = .scaleAspectFit
    return imv
  }()
  
  // MARK: - Init
  override init(frame: CGRect) {
    super.init(frame: frame)
    prepareLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Prepare Layout
  private func prepareLayout(){
    qrImageView.layout{
      addSubview($0)
      $0.fill()
    }
    let currencyWithMultiplier: CGFloat = ((15 * 100)/76)/100
    currencyImageView.layout{
      addSubview($0)
      $0.width(dimension: qrImageView.widthAnchor, multiplier: currencyWithMultiplier)
        .height(dimension: $0.widthAnchor)
        .center()
    }
  }
  
  // MARK: - Set Data
  final func setQrImage(_ qr: UIImage?){
    qrImageView.image = qr
  }
  
  final func setCurrencyImage(_ currency: UIImage?){
    currencyImageView.image = currency
  }
}
