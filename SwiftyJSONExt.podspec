Pod::Spec.new do |spec|
  spec.name                           = "SwiftyJSONExt"
  spec.version                        = "1.0.3"
  spec.summary                        = "Useful functionally extensions for SwiftyJSON framework."
  spec.homepage                       = "https://github.com/cuzv/SwiftyJSONExt"
  spec.license                        = "MIT"
  spec.author                         = { "Shaw" => "cuzval@gmail.com" }
    spec.ios.deployment_target          = "12.0"
#  spec.osx.deployment_target          = "10.15"
#  spec.watchos.deployment_target      = "4.0"
#  spec.tvos.deployment_target         = "12.0"
  spec.source                         = { :git => "https://github.com/cuzv/SwiftyJSONExt.git", :tag => "#{spec.version}" }
  spec.source_files                   = "Sources/**/*.swift"
  spec.requires_arc                   = true
  spec.swift_versions                 = '5'
  spec.dependency 'SwiftyJSON', '~> 5.0.1'
  spec.dependency 'Alamofire', '~> 5.8.1'
  spec.dependency 'Infra'
end
