//
//  KHQRMainView.swift
//  WingKHQRTest
//
//  Created by Ouch Kemvanra on 2/6/24.
//

import UIKit

class KHQRMainView: UIView{
  
  // MARK: - Layout
  private
  lazy var bankLogoView : KHQRBankLogoView = {
    let view = KHQRBankLogoView()
    let height = KHQRConfig.wingLogoHeight
    view.backgroundColor = .white
    view.layer.cornerRadius = height/2
    view.clipsToBounds = true
    
    /// Constraint
    let width : CGFloat = height * 136/41
    view.height(height)
    view.width(width)
    return view
  }()
  
  private
  lazy var descriptionLabel: UILabel = {
    let label = UILabel()
    let fontSize: CGFloat = (KHQRConfig.sizeClass == .compact) || (KHQRConfig.sizeClass == .regular) ? 12:14
    label.font = KHQRFont.size(fontSize)
    label.textColor = .white
    label.textAlignment = .center
    label.numberOfLines = 2
    label.width(UIScreen.main.bounds.width * 0.61)
    label.height(40)
    return label
  }()
  
  private
  lazy var qrView: KHQRView = {
    let view = KHQRView()
    view.layer.cornerRadius = 20
    view.clipsToBounds = true
    view.backgroundColor = .white
    
    /// Constraint
    let height: CGFloat = (width * 29)/20
    view.height(height)
    view.width(width)
    return view
  }()
  
  private
  lazy var receivingToView: KHQRReceivingToView = {
    let view = KHQRReceivingToView()
    view.backgroundColor = .clear
    view.accountTapHandler = {[weak self] in
      self?.showAccountList?()
    }
    return view
  }()
  
  private
  lazy var setAmountButton: UIButton = {
    let btn = UIButton()
    btn.height(50)
    btn.width(width)
    btn.titleLabel?.font = KHQRFont.size(14, weight: .bold)
    btn.backgroundColor = .gray.withAlphaComponent(0.6)
    btn.layer.cornerRadius = 25
    btn.clipsToBounds = true
    btn.addTarget(self, action: #selector(didTapOnEnterAmount), for: .touchUpInside)
    return btn
  }()
  
  private lazy var exchangeRateLabel: UILabel = {
    let label = UILabel()
    label.font = KHQRFont.size(10)
    label.numberOfLines = 2
    label.textColor = .white
    label.isHidden = true
    label.sizeToFit()
    label.textAlignment = .center
    label.width(width)
    return label
  }()
  
  private
  lazy var actionButton: KHQRActionButtonView = {
    let view = KHQRActionButtonView.init(actionButtonList: actionButtonList)
    view.layer.cornerRadius = 25
    view.clipsToBounds = true
    view.backgroundColor = .white.withAlphaComponent(0.2)
    view.onClick = {[weak self] type in
      self?.onActionTap?(type)
    }
    return view
  }()
  
  private 
  lazy var stackView: UIStackView = {
    let stackView = UIStackView()
    stackView.distribution = .fill
    stackView.axis = .vertical
    stackView.spacing = 16
    stackView.alignment = .center
    return stackView
  }()
  
  // MARK: - Callback
  var onEnterAmount: KHQRCallback?
  var onActionTap: KHQRCallbackType<KHQRActionButtonType>?
  var showAccountList: KHQRCallback?
  
  // MARK: - Store Prop
  var khqrAccount: KHQRAccount?
  let width: CGFloat = UIScreen.main.bounds.width - (KHQRConfig.khqrViewPadding * 2)
  var actionButtonList: [KHQRActionButtonItem] = []
  
  init(actionButotnList: [KHQRActionButtonItem]){
    self.actionButtonList = actionButotnList
    super.init(frame: .zero)
    prepareLayout()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    prepareLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private
  func prepareLayout(){

    stackView.addArrangedSubview(bankLogoView)
    stackView.addArrangedSubview(descriptionLabel)
    stackView.addArrangedSubview(qrView)
    stackView.addArrangedSubview(receivingToView)
    stackView.addArrangedSubview(exchangeRateLabel)
    stackView.addArrangedSubview(setAmountButton)
    stackView.addArrangedSubview(actionButton)
    stackView.layout{
      addSubview($0)
      $0.fill()
    }
  }
}

extension KHQRMainView{
  final func setTopLogo(_ logo: UIImage?){
    bankLogoView.setLogo(logo)
  }
  
  final func setDescriptionText(_ desc: String?){
    descriptionLabel.text = desc
  }
  
  final func setkhqrLogo(_ logo: UIImage?){
    qrView.setKHQRLogo(logo)
  }
  
  final func setEnterAmountText(_ text: String?){
    setAmountButton.setTitle(text, for: .normal)
  }
  
  final func setExchangeRateDisclaimerText(_ text: String?){
    exchangeRateLabel.text = text
  }
  
  final func setReceivingToText(_ text: String?){
    receivingToView.setRecievingToText(text)
  }
  
  final func setQrImage(_ qr: UIImage?){
    qrView.setQrImage(qr)
  }
  
  final func setCurrencyImage(_ currency: UIImage?){
    qrView.setCurrencyImage(currency)
  }
  
  final func setReceivingToRightImage(_ image: UIImage?){
    receivingToView.setRightImage(image)
  }
}

extension KHQRMainView{
  final func setAccountData(_ data: KHQRAccount?){
    self.khqrAccount = data
    
    ///Receiving To
    let currency = data?.currency ?? ""
    let accountWithCurrency = (data?.accountNumber ?? "") + " (\(currency.uppercased()))"
    self.receivingToView.setAccountNumber(accountWithCurrency)
    
    /// Set QR Data
    let qr = QRGenerator.shared.generateQRCode(from: data?.qr ?? "")
    self.setCurrencyImage(data?.currencyImage)
    self.setQrImage(qr)
    self.qrView.setAccountData(data)
    
    self.exchangeRateLabel.isHidden = data?.amount == 0.0
    self.setAttentionVisible(show: data?.amount != 0.0)
  }
  
  final func setAttentionVisible(show: Bool, animated: Bool = true) {
    UIView.animate(withDuration: animated ? 0.3 : 0.0, delay: 0, options: [.curveEaseInOut], animations: { [weak self] in
      guard let self = self else { return }
      self.exchangeRateLabel.alpha = show ? 1.0 : 0.0
      self.exchangeRateLabel.isHidden = !show
      if show{
        self.actionButton.removeButton(.save)
      } else{
        self.actionButton.showButton(.save)
      }
      self.setNeedsLayout()
      self.layoutIfNeeded()
    }, completion: { _ in
      self.exchangeRateLabel.isHidden = !show
      if show{
        self.actionButton.removeButton(.save)
      } else{
        self.actionButton.showButton(.save)
      }
    })
  }
}

// MARK: - Action Control
extension KHQRMainView{
  @objc
  private func didTapOnEnterAmount(){
    guard khqrAccount != nil else{
      return
    }
    onEnterAmount?()
  }
  final func getMainViewSize() -> CGRect{
    let width = (UIScreen.main.bounds.width - (KHQRConfig.khqrViewPadding * 2))
    let height = ((UIScreen.main.bounds.width - (KHQRConfig.khqrViewPadding * 2)) * 29)/20
    return .init(x: 0, y: 0, width: width, height: height)
  }
}
