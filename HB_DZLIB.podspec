
Pod::Spec.new do |s|
  s.name         = "HB_DZLIB"
  s.version      = "0.0.1"
  s.summary      = "HB_DZLIB IS ROCKMOBILE LIB"

  s.description  = <<-DESC
                   A longer description of HB_DZLIB in Markdown format.

                   * Think: Why did you write this? What is the focus? What does it do?
                   * CocoaPods will be using this to generate tags, and improve search results.
                   * Try to keep it short, snappy and to the point.
                   * Finally, don't worry about the indent, CocoaPods strips it!
                   DESC

  s.homepage     = "https://github.com/Natoto/HB_DZLIB"
  s.license      = "MIT (example)"
  # s.license      = { :type => "MIT", :file => "FILE_LICENSE" }
  s.author             = { "Natoto" => "787038442@qq.com" }

  # s.platform     = :ios
    s.platform     = :ios, "5.0"

  #  When using multiple platforms
    s.ios.deployment_target = "5.0"
  # s.osx.deployment_target = "10.7"

  s.source       = { :git => "https://github.com/Natoto/HB_DZLIB.git", :commit => "9c8065dab46c503be3dc32b2c2455abcbfe9c83c" }


  s.source_files  = "HB_DZLIB/", "HB_DZLIB/**/*.{h,m}"

   s.resources = "HB_DZLIB/**/*.png"
   s.frameworks = "CoreText", "CoreGraphics","AssetsLibrary","CoreImage","Foundation","UIKit"

  s.requires_arc = true
   s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
end
