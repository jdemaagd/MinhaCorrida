# [Manage Secrets](https://www.lordcodes.com/articles/managing-secrets-within-an-ios-app)

## [CocoaPodsKeys](https://github.com/orta/cocoapods-keys)

- ~/.cocaapods/keys
- values save in keychain 
  - cocoapods-keys-AppName

## [Shared Schema](https://docs.microsoft.com/en-us/appcenter/build/troubleshooting/ios)

- Product > Scheme > Manage schemes
- include: AppName.xcodeproj/xcshareddata/xcschemes/AppName.xcscheme

## [Code Signing](https://docs.microsoft.com/en-us/appcenter/build/ios/code-signing)

- Provisioning Profile (.mobileprovision)
  - ~/Library/MobileDevice/Provision Profiles/..
  - Upload correct file to App Center
- Certificate (.p12 file)
  - Download certificate from Apple Developer Portal
  - Open downloaded certificate with KeyChain Acess.app
  - Export 2 items (certificate and private key)
  - Upload Certificate.p12 to App Center

## App Center CocoaPods Keys ERROR

```
  [command]/usr/local/lib/ruby/gems/2.6.0/bin/pod install --repo-update
  [!] Your Podfile requires that the plugin `cocoapods-keys` be installed. Please install it and try installation again.
  ##[error]The process '/usr/local/lib/ruby/gems/2.6.0/bin/pod' failed with exit code 1
  ##[error]The 'pod' command failed with error: The process '/usr/local/lib/ruby/gems/2.6.0/bin/pod' failed with exit code 1
```

## [Secrets Center](https://github.com/AaronTunney/SecretsCenter)

- gem install bundler
- bundle install
- bundle exec pod install

