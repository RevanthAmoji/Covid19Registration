# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'
source 'https://github.com/joshbirnholz/JBPodSpecs.git'

target 'covid' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for covid
  #pod 'Alamofire', '~> 5.0'
  pod 'JBCalendarDatePicker'
  pod 'Alamofire',
          :git => 'https://github.com/Alamofire/Alamofire.git',
      :branch => 'master',
        :tag => '5.0.0'
        
  pod 'JTMaterialSpinner',
          :git => 'https://github.com/jonathantribouharet/JTMaterialSpinner',
          :branch => 'master',
          :tag => '3.0.5'
          
  pod 'NVActivityIndicatorView',
          :git => 'https://github.com/ninjaprox/NVActivityIndicatorView',
          :branch => 'master',
          :tag => 'v3.5'
  
  target 'covidTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'covidUITests' do
    # Pods for testing
  end

end
