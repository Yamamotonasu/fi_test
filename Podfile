# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

def rswift
  pod 'R.swift'
end

def firebase
  pod 'Firebase/Analytics'
  pod 'Firebase/Auth'
end

def facebook_sdk
  pod 'FBSDKCoreKit/Swift'
  pod 'FBSDKLoginKit/Swift'
end

target 'FirebaseTest' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  
  rswift
  firebase
  facebook_sdk

  # Pods for FirebaseTest

  # add pods for desired Firebase products
  # https://firebase.google.com/docs/ios/setup#available-pods1
  pod 'Firebase/Analytics'
end
