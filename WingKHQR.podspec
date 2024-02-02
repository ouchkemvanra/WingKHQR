Pod::Spec.new do |s|
  s.name             = "WingKHQR"
  s.version          = "0.1.0"
  s.summary          = "Custom view for wing khqr"
  s.homepage         = "https://github.com/ouchkemvanra/WingKHQR.git"
  s.license          = 'Code is MIT, then custom font licenses.'
  s.author           = { "RA" => "ouchkemvanra1@gmail.com" }
  s.source           = { :git => "https://github.com/ouchkemvanra/WingKHQR.git", :tag => s.version }

  s.platform     = :ios, '12.0'
  s.requires_arc = true

  s.source_files = 'WingKHQR/WingKHQR/**/*'

  s.frameworks = 'UIKit'
end