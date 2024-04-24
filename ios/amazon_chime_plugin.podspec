#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint amazon_chime_plugin.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'amazon_chime_plugin'
  s.version          = '0.0.1'
  s.summary          = 'A new Flutter plugin project.'
  s.description      = <<-DESC
A new Flutter plugin project.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.dependency 'AmazonChimeSDK-Bitcode', '= 0.25.0'
  s.platform = :ios, '16.0'

  # Flutter.framework does not contain a i386 slice.
  s.swift_version = '5.0'
end
