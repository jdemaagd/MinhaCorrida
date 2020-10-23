#!/usr/bin/env bash
 
# Install JSON tool
echo "Install jq"
brew install jq 
 
# Install Cocoapods-keys
echo "Installing gems"
bundle install

echo "Setting secrets"
cd $APPCENTER_SOURCE_DIRECTORY
bundle exec pod keys set "AppCenterAppSecret" "$AppCenterAppSecret" MinhaCorrida
bundle exec pod keys set "AzureMinhaCorridaBaseUrl" "$AzureMinhaCorridaBaseUrl" MinhaCorrida
bundle exec pod keys set "AzureMinhaCorridaFunctionKey" "$AzureMinhaCorridaFunctionKey" MinhaCorrida

echo "Installing pods"
bundle exec pod install

echo "Printing keys:"
bundle exec pod keys

echo "Generating secrets files"
bundle exec pod keys generate MinhaCorrida
