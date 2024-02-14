//
//  KHQRBankLogoView.swift
//  WingKHQRTest
//
//  Created by Ouch Kemvanra on 2/6/24.
//

import UIKit

final class KHQRBankLogoView: UIView{
  
  // MARK: - Layout
  let wingLogoHeight: CGFloat = {
    switch KHQRConfig.sizeClass {
    case.extraLarge:
      return 40 - 16
    case .large:
      return 40 - 16
    case .compact:
      return 30 - 16
    case .regular:
      return 40 - 16
    }
  }()
  
  private
  lazy var logoImageView : UIImageView = {
    let imv = UIImageView()
    imv.contentMode = .scaleAspectFit
    return imv
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    prepareLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  final func setLogo(_ logo: UIImage?){
    logoImageView.image = logo
  }
  
  private
  func prepareLayout(){
    logoImageView.layout{
      addSubview($0)
      $0.center()
        .top(8)
        .bottom(8)
    }
  }
}

