#
# Be sure to run `pod lib lint SiriSlider.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SiriSlider'
  s.version          = '0.1.1'
  s.summary          = 'SiriSlider is a highly customizable dual ends slider in UIKit'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'SiriSlider is a library designed to provide a customizable slider view for iOS applications. With SiriSlider, you can effortlessly adjust both minimum and maximum values using intuitive thumb controls. This feature-rich slider supports Right-to-Left (RTL) layout, ensuring compatibility with diverse language preferences and user interfaces. Whether you are developing a range picker, filter selector, or any application requiring precise value adjustment, ThumbSlider offers a seamless and visually appealing solution. With its straightforward integration and extensive customization options, ThumbSlider empowers developers to enhance user interaction and elevate the usability of their iOS applications'

  s.homepage         = 'https://github.com/ahmedbahgaten/SiriSlider'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'ahmedbahgat' => 'ahmedbahgatnabih@gmail.com' }
  s.source           = { :git => 'https://github.com/ahmedbahgaten/SiriSlider.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
  s.swift_version = '5.0'
  s.ios.deployment_target = '13.0'

  s.source_files = 'SiriSlider/Classes/**/*'
  
  # s.resource_bundles = {
  #   'SiriSlider' => ['SiriSlider/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
   s.frameworks = 'UIKit', 'Combine'
  # s.dependency 'AFNetworking', '~> 2.3'
end
