Pod::Spec.new do |s|
  s.name         = "XXImageLoopView"
  s.version      = "1.0.0"
  s.summary      = "A fast integration images loop function of custom control"
  s.description  = "A fast integration images loop function of custom control addtion with cocoapod support."
  s.homepage     = "https://github.com/mengday/XXImageLoopView"
  s.license      = "MIT"
  s.author       = { "menday" => "mengd6@126.com" }
  s.source       = { :git => "https://github.com/mengday/XXImageLoopView.git", :tag => s.version }
  s.source_files = "XXImageLoopView/*.{h,m}"
  s.ios.deployment_target = '6.0'
  s.frameworks   = 'UIKit'

end
