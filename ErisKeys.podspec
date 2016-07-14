#
# Be sure to run `pod lib lint ErisKeys.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ErisKeys'
  s.version          = '0.1.0'
  s.summary          = 'Provides support to generate keys, sign and verify transactions on an Eris Blockchain.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Provides support to generate keys, sign and verify transactions on an Eris Blockchain. Encapsulates CommonCrypto.

                       DESC

  s.homepage         = 'https://gitlab.com/katalysis/ErisKeys'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'Apache License v2.0', :file => 'LICENSE' }
  s.author           = { 'Alex Tran Qui' => 'alex@katalysis.io' }
  s.source           = { :git => 'https://gitlab.com/katalysis/ErisKeys.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.9'
  s.watchos.deployment_target = '2.0'

  s.source_files = 'ErisKeys/Classes/**/*'
  
  # s.resource_bundles = {
  #   'ErisKeys' => ['ErisKeys/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
