# [Manage Secrets](https://www.lordcodes.com/articles/managing-secrets-within-an-ios-app)

## [CocoaPodsKeys](https://github.com/orta/cocoapods-keys)

- ~/.cocaapods/keys
- values save in keychain 
  - cocoapods-keys-AppName

## [Shared Schema](https://docs.microsoft.com/en-us/appcenter/build/troubleshooting/ios)

- Product > Scheme > Manage schemes
- include: AppName.xcodeproj/xcshareddata/xcschemes/AppName.xcscheme
- /Users/jdemaagd/Library/Developer/Xcode/DerivedData

## [Code Signing](https://docs.microsoft.com/en-us/appcenter/build/ios/code-signing)

- Provisioning Profile (.mobileprovision)
  - ~/Library/MobileDevice/Provision Profiles/..
  - Upload correct file to App Center
- Certificate (.p12 file)
  - Download certificate from Apple Developer Portal
  - Open downloaded certificate with KeyChain Acess.app
  - Export 2 items (certificate and private key)
  - Upload Certificate.p12 to App Center

## [Secrets Center](https://github.com/AaronTunney/SecretsCenter)

- gem install bundler
- bundle install
- bundle exec pod install
- bundle exec pod keys set KEY VALUE (save keys on per-project)
- bundle exec pod keys (list all keys)
- bundle exec pod keys get [key] [optional project] (get key)
- bundle exec pod keys rm [key] [optional project] (remove key)
- bundle exec pod keys rm --all (remove all keys)
- bundle exec pod keys rm "*" (remove keys matching pattern)
- bundle exec pod keys generate [optional project]

## Resources

- [Vim Replace](https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text)
- [Vim Find and Replace](https://vim.fandom.com/wiki/Search_and_replace)

