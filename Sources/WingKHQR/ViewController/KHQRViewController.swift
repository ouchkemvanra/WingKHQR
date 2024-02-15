//
//  KHQRViewController.swift
//  WingKHQRTest
//
//  Created by Ouch Kemvanra on 2/6/24.
//

import UIKit

public protocol KHQRViewControllerDelegate: NSObject{
  func switchAccount() -> KHQRAccount
  func enteAmount()
  func onActionTap(_ type: KHQRActionButtonType)
}

open class KHQRViewController: UIViewController{
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
      self?.delegate?.onActionTap(type)
    }
    return view
  }()
  
  // MARK: - Store Prop
  var khqrAccount: KHQRAccount?
  
  // MARK: - Init
  public init(_ data: KHQRAccount?){
    self.khqrAccount = data
    super.init(nibName: nil, bundle: nil)
  }
  
  public required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Life Cycle
  open override func viewDidLoad() {
    super.viewDidLoad()
    prepareLayout()
  }
  
  // MARK: - Prepare view layout
  private func prepareLayout(){
    view.backgroundColor = .black.withAlphaComponent(0.5)
    if let data = khqrAccount {
      mainView.setAccountData(data)
    }
    mainView.layout{
      view.addSubview($0)
      $0.center()
    }
  }
}
