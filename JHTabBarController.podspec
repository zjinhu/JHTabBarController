
Pod::Spec.new do |s|
  s.name             = 'JHTabBarController'
  s.version          = '0.0.6'
  s.summary          = 'JHTabBarController.'
 
  s.description      = <<-DESC
							工具.
                       DESC

  s.homepage         = 'https://github.com/jackiehu/' 
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'HU' => '814030966@qq.com' }
  s.source           = { :git => 'https://github.com/jackiehu/JHTabBarController.git', :tag => s.version.to_s }

  s.ios.deployment_target = "11.0" 
  s.swift_versions     = ['5.2', '5.1', '5.0']
  s.requires_arc = true
  s.frameworks   = "UIKit", "Foundation" 
  s.dependency 'SnapKit'
 
  s.subspec 'Core' do |ss|
      ss.source_files = 'JHTabBarController/JHTabBarController/Class/**/*.swift' 
    end

  s.subspec 'Lottie' do |ss| 
      ss.dependency 'JHTabBarController/Core'
      ss.dependency 'lottie-ios'
    end
    
  s.default_subspec = 'Core'

end
