//
//  KHQRReceivingToView.swift
//  WingKHQRTest
//
//  Created by Ouch Kemvanra on 2/12/24.
//

import UIKit

class KHQRReceivingToView: UIView{
  private lazy var receivingToLabel: UILabel = {
    let lb = UILabel()
    lb.textColor = .white
    lb.font = KHQRFont.size(14)
    lb.textAlignment = .right
    lb.numberOfLines = 1
    return lb
 }()
 private lazy var accountButton : UIButton = {
    let btn = UIButton()
    btn.setTitle("012345678", for: .normal)
    btn.setTitleColor(.white, for: .normal)
    btn.setTitleColor(UIColor(hex: "#8494A0"), for: .highlighted)
    btn.imageEdgeInsets.right = -4
    //   btn.setImage(R.image.ic_curve_triangle(), for: .normal)
    btn.titleLabel?.textAlignment = .center
    btn.titleLabel?.font = KHQRFont.size(14, weight: .bold)
    btn.addTarget(self, action: #selector(onAccountTap), for: .touchUpInside)
    btn.semanticContentAttribute = .forceRightToLeft
    return btn
  }()
  
 var accountTapHandler: KHQRCallback?
  
 override init(frame: CGRect){
   super.init(frame: frame)
   prepareLayout()
 }
  convenience init(accountTapHandler: @escaping KHQRCallback) {
    self.init(frame: .zero)
    self.accountTapHandler = accountTapHandler
  }
 
 required init?(coder: NSCoder) {
   fatalError("init(coder:) has not been implemented")
 }
  
  private func prepareLayout(){
    receivingToLabel.layout{
      addSubview($0)
      $0.leading()
        .top()
        .bottom()
    }
    accountButton.layout{
      addSubview($0)
      $0.leading(constraint: receivingToLabel.trailingAnchor, 4)
        .top()
        .bottom()
        .trailing()
    }
  }
  
  @objc
  func onAccountTap(){
    accountTapHandler?()
  }
  
  final func setRecievingToText(_ text: String?){
    receivingToLabel.text = text
  }
}
