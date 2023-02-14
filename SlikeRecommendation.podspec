
Pod::Spec.new do |s|
  s.name             = 'SlikeRecommendation'
  s.version          = '1.1.1'
  s.summary          = 'A short description of SlikeRecommendation.'
  s.homepage         = 'timesinternet.in'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Aravind.kumar' => 'aravind.kumar@timesinternet.in' }
  s.source           = { :git => 'https://bitbucket.org/times_internet/slikerecommendation.git', :tag => s.version.to_s }
  s.ios.deployment_target = '12.0'
  s.swift_version = '5.0'
  s.ios.resource_bundle     = { 'SlikeRecResources' =>  ['SlikeRecommendation/SlikeRecResources/*'] }
  s.ios.deployment_target = '12.0'
  s.source_files = 'SlikeRecommendation/Classes/**/*'
  #s.dependency 'Alamofire'
  s.dependency 'AlamofireImage'
  s.dependency 'IQKeyboardManagerSwift', '6.3.0'

end
