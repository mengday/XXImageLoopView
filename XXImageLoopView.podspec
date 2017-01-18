Pod::Spec.new do |s|
  s.name         = "XXImageLoopView"
  s.version      = "1.0.0"
  s.ios.deployment_target = '6.0'
  s.osx.deployment_target = '10.8'
  s.summary      = "A fast integration images loop function of custom control"
  s.homepage     = "https://github.com/mengday/XXImageLoopView"
  s.license      = "MIT"
  s.author             = { "menday" => "mengd6@126.com" }
  s.social_media_url   = "http://weibo.com/exceptions"
  s.source       = { :git => "https://github.com/mengday/XXImageLoopView.git", :tag => s.version }
  s.source_files  = "XXImageLoopView/*.{h,m}"
  s.frameworks = 'UIKit'
  s.requires_arc = true
end
