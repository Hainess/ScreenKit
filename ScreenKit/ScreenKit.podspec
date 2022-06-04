#
# Be sure to run `pod lib lint ScreenKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ScreenKit'
  s.version          = '0.1.0'
  s.summary          = '屏幕适配检查. UI检查时，避免切换设备，可以在大屏上切换小屏幕📱效果'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/Hainess/ScreenKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Hainess' => 'Hainess@likpia.com' }
  s.source           = { :git => 'https://github.com/Hainess/ScreenKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '12.0'
  s.swift_version = '5.5'
  s.requires_arc = true
  s.frameworks = 'UIKit','Foundation'
  s.source_files = 'ScreenKit/Classes/**/*'
  
  # s.resource_bundles = {
  #   'ScreenKit' => ['ScreenKit/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
   s.dependency 'RxSwift', '~> 6.5.0'
   s.dependency 'RxCocoa', '~> 6.5.0'
   s.dependency 'RxDataSources'
   s.dependency 'SnapKit'
   s.dependency 'DeviceKit', '~> 4.6.0'
   s.dependency 'EachNavigationBar'
   s.dependency 'Then'
end
