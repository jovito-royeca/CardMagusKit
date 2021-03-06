#
# Be sure to run `pod lib lint CardMagusKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CardMagusKit'
  s.version          = '1.1.0'
  s.summary          = 'Core Data and utilities for Card Magus.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Core Data classes, database, and utilities for Card Magus.
                       DESC

  s.homepage         = 'https://github.com/jovito-royeca/CardMagusKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'jovito-royeca' => 'jovit.royeca@gmail.com' }
  s.source           = { :git => 'https://github.com/jovito-royeca/CardMagusKit.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/JovitoRoyeca'

  s.ios.deployment_target = '9.0'

  s.source_files = 'CardMagusKit/Classes/**/*'
  
  s.resource_bundles = {
    'CardMagusKit' => ['CardMagusKit/Assets/**/*',
                       'CardMagusKit/Classes/**/*']
  }
  s.resources = 'CardMagusKit/Assets/**/*'

#  s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit', 'MapKit', 'Sync', 'DATASource', 'DATAStack', 'Networking', 'ReachabilitySwift', 'SSZipArchive', 'Kanna'
  s.dependency 'Sync'
  s.dependency 'DATASource'
  s.dependency 'DATAStack', '~> 6'
  s.dependency 'Networking'
  s.dependency 'ReachabilitySwift'
  s.dependency 'SSZipArchive'
  s.dependency 'Kanna'
end
