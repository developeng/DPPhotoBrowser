#
#  Be sure to run `pod spec lint DPPhotoBrowser.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  spec.name         = "DPPhotoBrowser"
  spec.version      = "0.0.1"
  spec.summary      = "图片放大查看，图片保存"
  spec.homepage     = "https://github.com/developeng/DPPhotoBrowser"
  spec.license      = "MIT"
  spec.author             = { "developeng" => "developeng@163.com" }
  spec.swift_version  = "5.0"
  spec.platform     = :ios, "10.0"
  spec.source       = { :git => "https://github.com/developeng/DPPhotoBrowser.git", :tag => spec.version }
  spec.source_files  = "DPPhotoBrowser/DPPhotoBrowser/*.swift"
  spec.frameworks = "UIKit", "Foundation"
  spec.requires_arc = true
  spec.dependency 'Kingfisher', '~> 6.1.0'

end
