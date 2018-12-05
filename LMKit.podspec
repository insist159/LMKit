Pod::Spec.new do |s|
  s.name         = "LMKit"
  s.version      = "0.0.1"
  s.summary      = "A short description of LMKit."
  s.description  = "LMKit FOR ZOMBIES"
  s.homepage     = "https://github.com/insist159/LMKit.git"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author             = { "insist159" => "insist159@163.com" }
  s.social_media_url   = "https://weibo.com/u/2948779441"
  s.platform     = :ios, "10.0"
  s.source       = { :git => "https://github.com/ChenYilong/CYLTabBarController.git", :tag => s.version.to_s}
  s.source_files  = 'LMKit', 'LMKit/**/*.{h,m}'
  s.public_header_files = 'LMKit/**/*.h'
  s.requires_arc = true
  s.libraries = 'z', 'sqlite3'
  s.frameworks = 'Foundation', 'CoreFoundation','UIKit', 'CoreText', 'CoreGraphics', 'CoreImage', 'QuartzCore', 'ImageIO', 'AssetsLibrary', 'Accelerate', 'MobileCoreServices', 'SystemConfiguration'
end
