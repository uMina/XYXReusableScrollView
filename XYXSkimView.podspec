Pod::Spec.new do |s|


  s.name         = "XYXSkimView"
  s.version      = "1.0.3"
  s.summary      = "横向的、可复用的滚动视图"
  s.swift_version = "4.0"

  s.description  = <<-DESC
  横向的、可复用的滚动视图。可以从xib文件或者纯代码构建cell。
                   DESC
  s.homepage     = "https://github.com/uMina/XYXSkimViewDemo"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Teresa" => "yxx.umina@gmail.com" }
  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://github.com/uMina/XYXSkimViewDemo.git", :tag => "#{s.version}" }
  s.source_files  = "XYXSkimView", "XYXSkimView/*.swift"

end
