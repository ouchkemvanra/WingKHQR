//
//  KHQRViewController.swift
//  WingKHQRTest
//
//  Created by Ouch Kemvanra on 2/6/24.
//

import UIKit

public protocol KHQRViewControllerDelegate: NSObject{
  func showAccountList()
  func enteAmount()
  func onActionTap(_ type: KHQRActionButtonType)
  func saveImage(_ image: UIImage)
  func saveImageSucess()
  func saveImageFail()
  func shareLink()
}

open class KHQRViewController: KHQRDialogueViewController{
  // MARK: - To Do
  /// Override Properties
  /// Bottom ActionButton item
  open var bottomActionButtonList: [KHQRActionButtonItem] {
    get{
      return [
      
      ]
    }
  }
  
  /// Top White Background Bank Logo with round corner
  public var logo: UIImage? {
    didSet{
      mainView.setTopLogo(logo)
    }
  }
  
  /// KHQR Logo
  public var khqrLogo: UIImage?{
    didSet{
      mainView.setkhqrLogo(khqrLogo)
    }
  }
  
  /// Currency Logo
  public var currencyImage: UIImage?{
    didSet{
      mainView.setCurrencyImage(currencyImage)
    }
  }
  
  /// Description Text under Top Logo
  public var topDescriptionText: String?{
    didSet{
      mainView.setDescriptionText(topDescriptionText)
    }
  }
  
  /// Receiveing To Text
  public var receivingToText: String?{
    didSet{
      mainView.setReceivingToText(receivingToText)
    }
  }
  
  /// Receiving to image
  public var receivingToImage: UIImage?{
    didSet{
      mainView.setReceivingToRightImage(receivingToImage)
    }
  }
  
  /// Exchange Rate Disclaimer Text
  public var exchangeRateDisclaimerText: String?{
    didSet{
      mainView.setExchangeRateDisclaimerText(exchangeRateDisclaimerText)
    }
  }
  
  /// Enter Amount Text
  public var enterAmountText: String?{
    didSet{
      mainView.setEnterAmountText(enterAmountText)
    }
  }
  
  /// Should Remove Save button when has amount
  public var shouldRemoveSave: Bool{
    true
  }
  
  public var shareImageTitle: String?
  public var shareImageLogo: UIImage?
  
  // MARK: - Delegate
  public weak var delegate: KHQRViewControllerDelegate?
  
  // MARK: - Layout
  private
  lazy var mainView: KHQRMainView = {
    let view = KHQRMainView.init(actionButotnList: bottomActionButtonList)
    view.onEnterAmount = {
      self.delegate?.enteAmount()
    }
    view.onActionTap = {[weak self] type in
      self?.onActionTap(type)
    }
    
    let tap = UITapGestureRecognizer.init(target: self, action: #selector(dismissView))
    view.addGestureRecognizer(tap)
    view.isUserInteractionEnabled = true
    return view
  }()
  
  // MARK: - Store Prop
  public var khqrAccount: KHQRAccount?
  var screenshotViewController: KHQRScreenshotViewController!
  
  // MARK: - Init
  public init(_ data: KHQRAccount?){
    self.khqrAccount = data
    super.init()
  }
  
  public required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Life Cycle
  open override func viewDidLoad() {
    super.viewDidLoad()
    prepareLayout()
    mainView.setAccountData(khqrAccount)
  }
  
  // MARK: - Prepare view layout
  private func prepareLayout(){
    if let data = khqrAccount {
      mainView.setAccountData(data)
    }
    mainView.layout{
      view.addSubview($0)
      $0.center()
    }
  }
  
  open override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    addScreenshotObserve()
  }
  
  open override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    removeScreenshotObserver()
  }
}

// MARK: - Action Control
extension KHQRViewController{
  @objc
  func dismissView(){
    self.dismiss(animated: true, completion: nil)
  }
}

// MARK: - Screenshot
extension KHQRViewController{
  private func removeScreenshotObserver(){
    NotificationCenter.default.removeObserver(self, name: UIApplication.userDidTakeScreenshotNotification, object: nil)
  }
  private func addScreenshotObserve(){
    NotificationCenter.default.addObserver(self, selector: #selector(screenshotTaken), name: UIApplication.userDidTakeScreenshotNotification, object: nil)
  }
  
  @objc private func screenshotTaken(){
    screenshotTap()
  }
  private func screenshotTap(){
    guard let data = khqrAccount else {return}
    self.screenshotViewController = KHQRScreenshotViewController.init(data)
    presentModal(screenshotViewController, animated: true, completion: {
      
      guard let img = QRGenerator.shared.renderQRCodeImage(from: self.screenshotViewController.getMainView()) else{return}
      
      ShareSheetManager.shared.showShareSheet(img, title: self.shareImageTitle ?? "", from: self.screenshotViewController, saveImageSuccess: {
        self.delegate?.saveImageSucess()
      }, logoIcon: self.shareImageLogo!)
    })
  }
}

// MARK: - Action Share Screenshot Save
extension KHQRViewController{
  private func onActionTap(_ type: KHQRActionButtonType){
    guard khqrAccount != nil else{
      return
    }
    
    switch type {
      case .screenshot:
        screenshotTap()
      case .save:
        saveQRImage()
      case .share:
        delegate?.shareLink()
        break
    }
  }
  
  private func saveQRImage(){
    guard let acc = khqrAccount else { return }
    let screenshotView = KHQRView.init(data: acc, frame: mainView.getMainViewSize())
    screenshotView.layer.cornerRadius = 16
    screenshotView.setNeedsLayout()
    screenshotView.setNeedsDisplay()
    screenshotView.layoutIfNeeded()
    screenshotView.clipsToBounds = true
    
    guard  let image = screenshotView.image() else{return}
    
    saveImageLocally(image: image)
  }
  
  func saveImageLocally(image: UIImage){
    delegate?.saveImage(image)
  }
}

extension KHQRViewController{
  public func setKHQRAccount(_ khqrAccount: KHQRAccount){
    self.khqrAccount = khqrAccount
    self.mainView.setAccountData(khqrAccount)
  }
}
