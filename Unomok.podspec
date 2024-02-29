Pod::Spec.new do |spec|

spec.name         = "Unomok"
spec.version      = "1.0.6"
spec.summary      = "Mok is a customer engagement platform for websites and mobile apps."
spec.description  = <<-DESC
Mok is a customer engagement platform for websites and mobile apps. It offers an integrated suite for simplifying notifications for engineering and product management.
DESC

spec.swift_version = "5.0"
spec.homepage     = "https://github.com/unotag/mok-ios-example-app"
spec.license      = { :type => "MIT", :file => "LICENSE.txt" }
spec.author             = { "Unomok Limited" => "support@unomok.com" }
spec.platform     = :ios, "16.0"
spec.source       = { :git => "https://github.com/unotag/unomok-sdk-ios.git", :tag => "#{spec.version}" }
spec.source_files = 'MokSDKExample/Unomok.xcframework/**/*.{swift,h,m}'
spec.vendored_frameworks = 'MokSDKExample/Unomok.xcframework'
spec.resource = 'README.md'
spec.library = "sqlite3"
spec.dependency 'Firebase', '~> 10.21.0'
spec.dependency 'SDWebImage', '~> 5.18.10'
spec.dependency 'EasyTipView', '~> 2.1.0'
end
