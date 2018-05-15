#
# Be sure to run `pod lib lint tryon-module-ios.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
s.name             = 'tryon-module-ios-debug'
s.version          = '0.1.0'
s.summary          = 'A short description of tryon-module-ios.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

s.description      = <<-DESC
TODO: Add long description of the pod here.
DESC

s.homepage         = 'http://10.157.26.43:7990/projects/SA/repos/tryon-module-ios/browse'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'supermariobean' => 'david.fu.zju.dev@gmail.com' }
s.source           = { :git => 'http://10.157.26.43:7990/scm/sa/tryon-module-ios.git', :tag => s.version.to_s }

s.ios.deployment_target = '9.0'

s.static_framework = true

s.source_files = [
'tryon-module-ios/Classes/**/*'
]
end

