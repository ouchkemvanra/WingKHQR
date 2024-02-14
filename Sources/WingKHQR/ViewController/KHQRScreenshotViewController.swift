//
//  KHQRScreenshotViewController.swift
//  WingKHQRTest
//
//  Created by Ouch Kemvanra on 2/14/24.
//

import UIKit

open class KHQRScreenshotViewController: UIViewController{
  // MARK: - To Do
  var khqrLog: UIImage?{
    didSet{
      qrView.setKHQRLogo(khqrLog)
    }
  }
  
  var currenyImage: UIImage?{
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
    
  }
  
  private
  func prepareLayout(){
    let height = (UIScreen.main.bounds.width - (padding * 2) * 29) / 20
    qrView.setQrImage(QRGenerator.shared.generateQRCode(from: data.qr))
    qrView.layout{
      view.addSubview($0)
      $0.center()
        .height(height)
        .leading(padding)
        .trailing(padding)
    }
  }
}
