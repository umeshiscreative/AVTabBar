Pod::Spec.new do |s|
  s.name             = 'AVTabBar'
  s.version          = '1.0.0'
  s.summary          = 'This is a simple Cocoapod for creating Tabbar in iOS.'
  s.description      = <<-DESC
"This is a simple Cocoapod for creating Tabbar in iOS. Its provide some basic extension and subclassing for UIKit for UI Designs."
                       DESC
  s.homepage         = 'https://github.com/umeshiscreative/AVTabBar'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Umesh' => 'umeshiscreative@gmail.com' }
  s.source           = { :git => 'https://github.com/umeshiscreative/AVTabBar.git', :tag => s.version.to_s }
  s.ios.deployment_target = '10.0'
  s.source_files = 'AVTabBar/Classes/*.swift'
  s.frameworks = 'UIKit'
  s.swift_version = '5.0'
end
