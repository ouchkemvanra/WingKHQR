//
//  KHQRView.swift
//  WingKHQRTest
//
//  Created by Ouch Kemvanra on 2/6/24.
//

import UIKit

class KHQRView: UIView{
  
  // MARK: - Layout
  private
  lazy var headerView : KHQRHeaderView = {
    let view = KHQRHeaderView.init()
    return view
  }()
  
  private
  lazy var accountNameLabel: UILabel = {
    let label = UILabel()
    label.textColor = KHQRConfig.khqrDarkText
    label.textAlignment = .left
    label.numberOfLines = 1
    label.text = "xxxx xxxx"
    label.height(20)
    return label
  }()
  
  private
  lazy var amountLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .left
    label.numberOfLines = 1
    label.setAmountKHQR(amount: "100 ", currency: "USD")
    label.height(25)
    let tap = UITapGestureRecognizer(target: self, action: #selector(didTapOnAmount))
    label.isUserInteractionEnabled = true
    label.addGestureRecognizer(tap)
    return label
  }()
  
  private
  lazy var dashLineView: KHQRDashLineView = {
    let dash = KHQRDashLineView()
    dash.dashColor = .init(hex: "#00000080")
    dash.perDashLength = 10
    dash.spaceBetweenDash = 4
    dash.backgroundColor = .white
    return dash
  }()
  
  private
  lazy var qrImage: KHQRCurrencyImageView = {
    let imv = KHQRCurrencyImageView()
    imv.contentMode = .scaleAspectFit
    return imv
  }()
  
  /// Spacing
  let leftRightPadding: CGFloat = 30
  let largePadding: CGFloat = KHQRConfig.sizeClass == .compact ? 8:(KHQRConfig.sizeClass == .regular ? 20:24)
  let headerHeight: CGFloat = KHQRConfig.sizeClass == .compact ? 40 : 50
  
  // MARK: - Store Prop
  var data: KHQRAccount?
  var onAmountTap: KHQRCallback?
  
  // MARK: - Init
  override init(frame: CGRect) {
    super.init(frame: frame)
    prepareLayout()
  }
  
  init(data: KHQRAccount, frame: CGRect){
    self.data = data
    super.init(frame: frame)
    prepareLayout()
    let qr = QRGenerator.shared.generateQRCode(from: data.qr)
    setQrImage(qr)
    setAccountData(data)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Prepare Layout
  private
  func prepareLayout(){
    
    headerView.layout{
      addSubview($0)
      $0.height(KHQRConfig.khqrRedHeaderHeight)
        .top()
        .leading()
        .trailing()
    }
    
    accountNameLabel.layout{
      addSubview($0)
      $0.top(constraint: headerView.bottomAnchor)
        .leading(KHQRConfig.khqrQRLeftRightPadding)
        .trailing(KHQRConfig.khqrQRLeftRightPadding)
      
    }
    
    amountLabel.layout{
      addSubview($0)
      $0.top(constraint: accountNameLabel.bottomAnchor, 4)
        .leading(KHQRConfig.khqrQRLeftRightPadding)
        .trailing(KHQRConfig.khqrQRLeftRightPadding)
    }
    
    dashLineView.layout{
      addSubview($0)
      $0.height(1)
        .top(constraint: amountLabel.bottomAnchor, largePadding)
        .leading()
        .trailing()
    }
    
    qrImage.layout{
      addSubview($0)
      $0.leading(KHQRConfig.khqrQRLeftRightPadding)
        .trailing(KHQRConfig.khqrQRLeftRightPadding)
        .top(constraint: dashLineView.bottomAnchor, KHQRConfig.khqrQRTopBottomPadding)
        .bottom(constraint: bottomAnchor, KHQRConfig.khqrQRTopBottomPadding)
    }
  }
}

extension KHQRView{
  @objc private func didTapOnAmount(){
    onAmountTap?()
  }
  final func setKHQRLogo(_ logo: UIImage?){
    headerView.setLogoImage(logo)
  }
  
  final func setQrImage(_ qr: UIImage?){
    qrImage.setQrImage(qr)
    if data?.qr.isEmpty == true{
      qrImage.setQrImage(nil)
    }
  }
  
  final func setCurrencyImage(_ currency: UIImage?){
    qrImage.setCurrencyImage(currency)
  }
  
  final func setAccountData(_ data: KHQRAccount?){
    self.accountNameLabel.text = (data?.name ?? "")
    let amountString = data?.currency.uppercased() == "USD" ? data?.amount.currencyFormat : data?.amount.khCurrencyFormat
    self.amountLabel.setAmountKHQR(amount: (amountString ?? "") + " ", currency: data?.currency ?? "")
  }
}
