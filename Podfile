platform :ios, '12.0'
use_frameworks!

# Pods for ActioID
target 'ActioID' do
  pod 'Firebase/Firestore'
  pod 'Firebase/Core'
  pod 'Firebase/Auth'
  pod 'FirebaseFirestoreSwift'
  pod 'Firebase/Analytics'
  pod 'Firebase/Crashlytics'
  pod 'Alamofire', '~> 5.2'
  pod 'SwiftyJSON', '~> 5.0'
end

target 'ActioIDTests' do
  inherit! :search_paths # Pods for testing
end

target 'ActioIDUITests' do
  # Pods for testing
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      
config.build_settings['CLANG_WARN_QUOTED_INCLUDE_IN_FRAMEWORK_HEADER'] = 
'NO'
    end
  end
end

