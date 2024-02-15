Pod::Spec.new do |spec|

spec.name         = "Unomok"
spec.version      = "1.0.2"
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
# spec.vendored_frameworks = 'Unomok.xcframework'

# spec.source_files  = "Classes", "Classes/**/*.{h,m}"
# spec.exclude_files = "Classes/Exclude"

# spec.public_header_files = "Classes/**/*.h"


# ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
#
#  A list of resources included with the Pod. These are copied into the
#  target bundle with a build phase script. Anything else will be cleaned.
#  You can preserve files from being cleaned, please don't preserve
#  non-essential files like tests, examples and documentation.
#

# spec.resource  = "icon.png"
# spec.resources = "Resources/*.png"

# spec.preserve_paths = "FilesToSave", "MoreFilesToSave"


# ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
#
#  Link your library with frameworks, or libraries. Libraries do not include
#  the lib prefix of their name.
#

# spec.framework  = "SomeFramework"
# spec.frameworks = "SomeFramework", "AnotherFramework"
spec.library = "sqlite3"
# spec.library   = "iconv"
# spec.libraries = "iconv", "xml2"


# ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
#
#  If your library depends on compiler flags you can set them in the xcconfig hash
#  where they will only apply to your library. If you depend on other Podspecs
#  you can include multiple dependencies to ensure it works.

# spec.requires_arc = true

# spec.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
# spec.dependency "JSONKit", "~> 1.4"

spec.dependency 'Firebase', '~> 10.21.0'
spec.dependency 'SDWebImage', '~> 5.18.10'
spec.dependency 'EasyTipView', '~> 2.1.0'
end
