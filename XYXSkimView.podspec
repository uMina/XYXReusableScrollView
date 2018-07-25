
Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  s.name         = "XYXSkimView"
  s.version      = "0.9.2"
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

  s.homepage     = "https://github.com/uMina/XYXSkimViewDemo"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"


  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Teresa" => "yxx.umina@gmail.com" }
  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://github.com/uMina/XYXSkimViewDemo.git", :tag => "#{s.version}" }
  s.source_files  = "XYXSkimView", "XYXSkimView/*.swift"
  
end
