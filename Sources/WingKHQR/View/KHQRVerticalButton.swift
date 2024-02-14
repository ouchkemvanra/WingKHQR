//
//  KHQRVerticalButton.swift
//  WingKHQRTest
//
//  Created by Ouch Kemvanra on 2/7/24.
//

import UIKit

class KHQRVerticalButton: UIButton {
  //MARK: - Constant
  /// Font
  var fontSize: CGFloat = 12 {
    didSet{
      if #available(iOS 13.0, *) {
        self.titleLabel?.font = KHQRFont.size(fontSize)
      } else {
        verticalTitleLabel.font = KHQRFont.size(fontSize)
      }
    }
  }
  
  /// Padding
  var padding: CGFloat = 4
  
  // MARK: - Store Prop
  var actionType: KHQRActionButtonItem
  var onTap: KHQRCallbackType<KHQRActionButtonType>?

  // MARK: - Layout
  lazy var verticalTitleLabel: UILabel = {
      let label = UILabel()
      label.font = KHQRFont.size(fontSize)
      label.numberOfLines = 0
      label.textColor = .white
      label.translatesAutoresizingMaskIntoConstraints = false
      return label
  }()
  
  private lazy var leftSeparator: UIView = {
    let view = UIView()
    view.backgroundColor = .init(hex: "#B0C1CE")
//    view.isHidden = true
    return view
  }()

  //MARK: - Init
  required init?(coder: NSCoder) {
    self.actionType = .init(type: .save, title: "Save", icon:nil)
    super.init(coder: coder)
    if #available(iOS 13.0, *) {

    } else {
      commonInit()
    }
    setupSeparator()
  }

  override init(frame: CGRect) {
    self.actionType = .init(type: .save, title: "Save", icon: nil)
    super.init(frame: frame)
    if #available(iOS 13.0, *) {

    } else {
      commonInit()
    }
    setupSeparator()
  }
  init(actionType: KHQRActionButtonItem){
    self.actionType = actionType
    super.init(frame: .zero)
    if #available(iOS 13.0, *) {

    } else {
      commonInit()
    }
    setupSeparator()
  }

  convenience init(title: String) {

    self.init(frame: .zero)
    verticalTitleLabel.text = title
  }
  
  private func commonInit() {
      addTarget(self, action: #selector(didTapOnButton(_:)), for: .touchUpInside)
      setTitle(actionType.title, for: .normal)
      let bottomPadding : CGFloat = KHQRConfig.sizeClass == .compact ? 0:-4
      addSubview(verticalTitleLabel)
      NSLayoutConstraint.activate([
          verticalTitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: bottomPadding),
          verticalTitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
          verticalTitleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 25.0)
      ])
    imageEdgeInsets.bottom = 8
  }
  
  @objc
  private func didTapOnButton(_ sender: KHQRVerticalButton){
    onTap?(actionType.type)
  }
  
  private func setupSeparator(){
    /// Separator
    leftSeparator.layout{
      addSubview($0)
      $0.leading(-1)
        .centerY()
        .width(1)
        .height(34)
    }
  }

  // MARK: - Prepare LAyout
  override func setTitle(_ title: String?, for state: UIControl.State) {
    if #available(iOS 13.0, *) {
      super.setTitle(title, for: state)
    } else {
      verticalTitleLabel.text = title
    }
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    if #available(iOS 13.0, *){
      setVerticalImage()
    } else{
      
    }
  }
  
  private func setVerticalImage(){
    
    let imageSize = imageView?.frame.size ?? .zero
    let titleSize = titleLabel?.frame.size ?? .zero
    let totalHeight = imageSize.height + titleSize.height + padding
    
    imageEdgeInsets = UIEdgeInsets(
      top: -(totalHeight - imageSize.height),
      left: 0,
      bottom: 0,
      right: -titleSize.width
    )
    
    titleEdgeInsets = UIEdgeInsets(
      top: 0,
      left: -imageSize.width,
      bottom: -(totalHeight - titleSize.height),
      right: 0
    )
  }
}
