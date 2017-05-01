Pod::Spec.new do |s|
  s.name             = "ErisKeys"
  s.version          = "0.3.8"
  s.summary          = "Keys capabilities for the Eris Blockchain in Swift."
  s.description  = <<-DESC
                   Keys generation, signature and verification capabilities for the Eris Blockchain in native Swift.
                   Copyright Katalysis 2016.
                   DESC
  s.homepage         = 'http://www.katalysis.io'
  s.license          = { :type => 'Apache v2.0', :file => 'LICENSE' }
  s.author           = { "Katalysis BV" => "info@katalysis.io" }
  s.source           = { :git => "https://gitlab.com/katalysis/ErisKeys.git", :tag => s.version.to_s }

  s.ios.deployment_target = '10.0'
  s.osx.deployment_target = '10.12'
  s.requires_arc = true

  s.source_files = [
    'Sources/*.swift',
  ]

  s.dependency 'RipeMD', '0.1.2'
  s.dependency 'Ed25519', '0.1.4'

end
