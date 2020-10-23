# [App Center](https://appcenter.ms/users/jdemaagd7/apps/MinhaCorrida/)

## Setup

- sudo gem install cocoapods
- pod init
- pod 'AppCenter'
- pod install
- use `MinhaCorrida.xcworkspace`
- [Certificate and Provision Profile](https://developer.apple.com/account/resources/certificates/list)
- [Create Certificate Signing Request (CSR)](https://doc.owncloud.com/branded_clients/branded_ios_app/publishing_ios_app_2.html)
    - Finder -> Applications -> Utilities -> Keychain Access
    - Keychain Access > Certificate Assistant > Request a Certificate From a Certificate Authority
- [Add shared Scheme](https://docs.microsoft.com/en-us/appcenter/build/troubleshooting/ios#no-scheme)
- include `*.xcworkspace` file to add xcode shared scheme `(*.xcscheme)`

## Analytics

- [Events](https://docs.microsoft.com/en-us/appcenter/analytics/event-metrics)
- [Analytics](https://docs.microsoft.com/en-us/appcenter/sdk/analytics/ios)
- [iOS](https://docs.microsoft.com/en-us/appcenter/sdk/getting-started/ios)
- [Crashes](https://docs.microsoft.com/en-us/appcenter/sdk/crashes/ios)
- [Mach exceptions](https://stackoverflow.com/questions/63137036/ios-setting-up-a-mach-exception-handler-without-interfering-with-lldb)

## [iOS Symbols](https://docs.microsoft.com/en-us/appcenter/diagnostics/ios-symbolication)

- Xcode -> Window -> Organizer -> Archives
- Select App -> Right-Click archive -> Show in Finder
- Right-Click `*.xcarchive` file -> Show Package Contents -> dSYMS

## Sign Builds

- [Provisioning Profile](https://docs.microsoft.com/en-us/appcenter/build/ios/code-signing)
    - Finder -> Go -> Go to Folder
        - ~/Library/MobileDevice/Provisioning Profiles/
        - Get info -> 
- [Podfile](https://guides.cocoapods.org/using/the-podfile.html)
- [Test on a real device](https://docs.microsoft.com/en-us/appcenter/build/build-test-integration)

## Resources

- [Release a Build](https://docs.microsoft.com/en-us/appcenter/distribution/uploading)
- [Managing Apps](https://docs.microsoft.com/en-us/appcenter/dashboard/creating-and-managing-apps)
- [Deploy](https://effectussoftware.com/blog/deploy-with-app-center/)
- [Alpha vs Beta](https://instabug.com/blog/alpha-vs-beta-apps/)
- [Distribution Tools](https://instabug.com/blog/comparison-between-top-beta-app-distribution-tools/)
- [Code Signing](https://developer.apple.com/support/code-signing/)

