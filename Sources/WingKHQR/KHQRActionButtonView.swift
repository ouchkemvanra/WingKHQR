//
//  KHQRActionButtonView.swift
//  WingKHQRTest
//
//  Created by Ouch Kemvanra on 2/7/24.
//

import UIKit
final class KHQRActionButtonItem{
  var type: KHQRActionButtonType
  var title: String
  var icon: UIImage?
  
  init(type: KHQRActionButtonType, title: String, icon: UIImage?) {
    self.type = type
    self.title = title
    self.icon = icon
  }
}
enum KHQRActionButtonType: Int{
  case screenshot = 0
  case save = 1
  case share  = 2
}


final class KHQRActionButtonView: UIView{
  
  // MARK: - Layout
  private
  var actionButtonList: [KHQRVerticalButton] = []
  
  private
  lazy var stackView: UIStackView = {
    let stackView = UIStackView.init(arrangedSubviews: actionButtonList)
    stackView.axis = .horizontal
    stackView.distribution = .fill
    stackView.spacing = 0
    return stackView
  }()
  
  // MARK: - Callback
  var onClick: KHQRCallbackType<KHQRActionButtonType>?
  
  var actionButtonListItem: [KHQRActionButtonItem] = []
  // MARK: - Init
  init(actionButtonList: [KHQRActionButtonItem]){
    super.init(frame: .zero)
    self.actionButtonListItem = actionButtonList
    setupStackView()
    preppareLayout()
  }
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupStackView()
    preppareLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private
  func setupStackView(){
    actionButtonList = actionButtonListItem.map({
      let btn = KHQRVerticalButton.init(actionType: $0)
      btn.fontSize = 10
      btn.setImage(.init(systemName: "info.circle"), for: .normal)
      btn.setTitle($0.title, for: .normal)
      btn.onTap = {type in
        
      }
      let width = (UIScreen.main.bounds.width - (KHQRConfig.khqrViewPadding * 2))/3
      btn.width(width)
      stackView.addArrangedSubview(btn)
      return btn
    })
  }
  
  private
  func preppareLayout(){
    stackView.layout{
      addSubview($0)
      $0.fill()
        .height(50)
    }
  }
  
  final
  func removeButton(_ actionType: KHQRActionButtonType){
    if let button = actionButtonList.first(where: {$0.actionType.type == actionType}){
      button.isHidden = true
    }
  }
  
  @objc
  private 
  func didTapOnButton(_ sender: KHQRVerticalButton){
    onClick?(sender.actionType.type)
  }
}