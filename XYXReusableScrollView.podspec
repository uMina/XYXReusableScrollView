#
#  Be sure to run `pod spec lint XYXReusableScrollView.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  s.name         = "XYXReusableScrollView"
  s.version      = "0.9"
  s.summary      = "横向的、可复用的滚动视图"
  s.swift_version = "4.0"
  
  # This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!
  s.description  = <<-DESC
  横向的、可复用的滚动视图。可以从xib文件或者纯代码构建cell。
                   DESC

  s.homepage     = "https://github.com/uMina/XYXReusableScrollView"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"


  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Teresa" => "yxx.umina@gmail.com" }
  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://github.com/uMina/XYXReusableScrollView.git", :tag => "#{s.version}" }
  s.source_files  = "XYXReusableScrollView", "XYXReusableScrollView/*.swift"
  
end
