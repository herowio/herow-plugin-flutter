#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint herow_plugin_flutter.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'herow_plugin_flutter'
  s.version          = '7.2.0'
  s.summary          = 'Herow plugin flutter for herow-sdk'
  s.description      = <<-DESC
Herow plugin flutter for herow-sdk
                       DESC
  s.homepage         = 'http://herow.io'
  s.license          = 'MIT'
  s.author           = { 'Herow' => 'contact@herow.io' }
  s.source       = {
    :http => "https://github.com/herowio/herow-sdk-ios/releases/download/v7.2.0/herow_sdk_ios.framework.zip",
    :type => "zip"
  }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.dependency "Herow"
  s.platforms    = { :ios => "11.0" }
  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
