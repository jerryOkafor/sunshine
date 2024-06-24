# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Sunshine' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Sunshine

  pod 'Alamofire', '~> 5.9.1'

  #Rx
  pod 'RxSwift', '~> 6.7.1'
  pod 'RxCocoa', '~> 6.7.1'
  pod 'RxSwiftExt', '~> 6.2.1'
  pod 'RxOptional'

  pod 'SnapKit', '~> 5.7.1'
  pod 'FSPagerView','~> 0.8.3'
  pod 'R.swift'
  pod 'Then'
  pod 'ActionSheetPicker-3.0', '~> 2.7.4'
  pod 'RxReachability', '~> 1.2.1'

  target 'SunshineTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'SunshineUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end

post_install do |installer|
     installer.generated_projects.each do |project|
           project.targets.each do |target|
               target.build_configurations.each do |config|
                   config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '17.5'
                end
           end
    end
 end
