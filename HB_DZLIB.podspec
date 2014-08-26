Pod::Spec.new do |s|
  s.name                  = "HB_DZLIB"
  s.version               = "0.0.1"
  s.summary               = "HB_DZLIB USED IN ROCKMOBILE YUNZHI GROUP TO MAKE DZ IOS VERSIONS TOOLS"
  s.homepage              = "https://github.com/Natoto/HB_DZLIB.git"
  s.social_media_url      = "https://github.com/Natoto/HB_DZLIB.git"
  s.platform     = :ios,'6.0'
  s.license               = { :type => "MIT", :file => "LICENSE" }
  s.author                = { "zhuchao" => "huang_bo_2011@163.com" }
  s.source                = { :git => "https://github.com/Natoto/HB_DZLIB.git",:tag=>"2.0.2"}
  s.ios.deployment_target = "6.0"
  s.requires_arc          = true
  s.framework             = "CoreFoundation","Foundation","CoreGraphics","UIKit","CoreText","CoreImage","AssetsLibrary"
  s.library		= "z.1.1.3","stdc++","sqlite3"
  s.subspec 'HB_DZLIB' do |sp|
    sp.source_files = '*.{h,m,mm}','./ARC/**/*.{h,m,mm}','./MRC/**/*.{h,m,mm}'
    sp.requires_arc = true
    sp.resources   = "./ARC/**/*.{png}","./ARC/**/*.Bundle"
    sp.xcconfig = { 'HEADER_SEARCH_PATHS' => '$(SDKROOT)/usr/include/libz, $(SDKROOT)/usr/include/libxml2', 'CLANG_CXX_LANGUAGE_STANDARD' => 'gnu++0x', 'CLANG_CXX_LIBRARY' => 'libstdc++', 'CLANG_WARN_DIRECT_OBJC_ISA_USAGE' => 'YES'}
  end
end
