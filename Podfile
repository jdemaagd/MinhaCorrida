platform :ios, '13.6'

target 'MinhaCorrida' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for MinhaCorrida
  pod 'AppCenter'

  plugin 'cocoapods-keys', {
    :project => "MinhaCorrida",
    :target => "MinhaCorrida",
    :keys => [
      "AppCenterAppSecret",
      "AzureMinhaCorridaBaseUrl",
      "AzureMinhaCorridaFunctionKey"
    ]
  }

  target 'MinhaCorridaTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'MinhaCorridaUITests' do
    # Pods for testing
  end

end
