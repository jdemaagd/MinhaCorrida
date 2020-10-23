# [Manage Secrets](https://www.lordcodes.com/articles/managing-secrets-within-an-ios-app)

## [CocoaPodsKeys](https://medium.com/@eelia/introduction-to-cocoapods-keys-840493b98ef1)

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

