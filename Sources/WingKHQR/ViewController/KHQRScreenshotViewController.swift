//
//  KHQRScreenshotViewController.swift
//  WingKHQRTest
//
//  Created by Ouch Kemvanra on 2/14/24.
//

import UIKit

open class KHQRScreenshotViewController: UIViewController{
  // MARK: - To Do
  open var khqrLog: UIImage?{
    didSet{
      qrView.setKHQRLogo(khqrLog)
    }
  }
  
  open var currenyImage: UIImage?{
    didSet{
      qrView.setCurrencyImage(currenyImage)
    }
  }
  
  // MARK: - Layout
  private
  var padding: CGFloat = {
    switch KHQRConfig.sizeClass{
      case .extraLarge, .large:
        return KHQRConfig.khqrViewPadding
      case .regular:
        return UIScreen.main.bounds.height < 812 ? 20 : KHQRConfig.khqrViewPadding
      default:
        return 20
    }
  }()
  
  private
  lazy var qrView: KHQRView = {
    let view = KHQRView()
    view.layer.cornerRadius = 20
    view.clipsToBounds = true
    view.backgroundColor = .white
    
    return view
  }()
  
  // MARK: - Init
  private var data: KHQRAccount
  
  init(_ data: KHQRAccount){
    self.data = data
    super.init(nibName: nil, bundle: nil)
  }
  
  required public init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  open override func viewDidLoad() {
    super.viewDidLoad()
    prepareLayout()
    currenyImage = data.currencyImage
    qrView.setAccountData(data)
  }
  
  private
  func prepareLayout(){
    view.backgroundColor = UIColor(hex: "#575757")
    let width = UIScreen.main.bounds.width - (padding * 2)
    let height = (width * 29) / 20
    qrView.setQrImage(QRGenerator.shared.generateQRCode(from: data.qr))
    qrView.layout{
      view.addSubview($0)
      $0.center()
        .height(height)
        .width(width)
    }
  }
  public func getMainView() -> UIView{
    return qrView
  }
}
