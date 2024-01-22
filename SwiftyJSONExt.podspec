Pod::Spec.new do |spec|
  spec.name             = "SwiftyJSONExt"
  spec.version          = "1.0.1"
  spec.summary          = "Useful functionally extensions for SwiftyJSON framework."
  spec.homepage         = "https://github.com/cuzv/SwiftyJSONExt"
  spec.license          = "MIT"
  spec.author           = { "Shaw" => "cuzval@gmail.com" }
  spec.platform         = :ios, "12.0"
  spec.source           = { :git => "https://github.com/cuzv/SwiftyJSONExt.git", :tag => "#{spec.version}" }
  spec.source_files     = "Sources/**/*.swift"
  spec.requires_arc     = true
  spec.swift_versions   = '5'
  spec.dependency 'SwiftyJSON', '~> 5.0.1'
end
