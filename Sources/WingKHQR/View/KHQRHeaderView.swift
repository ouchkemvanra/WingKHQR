//
//  KHQRHeaderView.swift
//  WingKHQRTest
//
//  Created by Ouch Kemvanra on 2/6/24.
//

import UIKit

class KHQRHeaderView: UIView{
  
  private
  lazy var bgView: UIView = {
    let view = UIView.init()
    view.backgroundColor = KHQRConfig.khqrRedColor
    return view
  }()
  
  private
  lazy var triangleView: KHQRTriangleView = {
    let view = KHQRTriangleView.init(color: KHQRConfig.khqrRedColor)
    view.backgroundColor = .white
    return view
  }()
  
  private
  lazy var logoImageView: UIImageView = {
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
  
  private
  func prepareLayout(){
    backgroundColor = .white
    
    bgView.layout{
      addSubview($0)
      $0.top()
        .leading()
        .trailing()
    }
    
    logoImageView.layout{
      bgView.addSubview($0)
      $0.size(width: 70, height: 16)
        .center()
    }
    
    triangleView.layout{
      addSubview($0)
      $0.trailing()
        .top(constraint: bgView.bottomAnchor)
        .bottom()
        .size(width: 25, height: 25)
    }
  }
  
  final
  func setLogoImage(_ logo: UIImage?){
    logoImageView.image = logo
  }
}

