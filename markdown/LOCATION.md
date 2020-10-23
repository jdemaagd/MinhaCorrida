# [Core Location](https://developer.apple.com/documentation/corelocation)

## Location Service

- Services for device geographic locations
- Framework gathers data using all available components on device
    - Wi-Fi, GPS, Bluetooth, magnetometer, barometer, cellular hardware
- Use Location Manager to configure, start/stop Core Location services

## [Location Manager](https://developer.apple.com/documentation/corelocation/cllocationmanager)

- Object used to start/stop delivery of location-related events to app
- Standard and significant location updates:
    - Track large or small changes in users current location with configurable degree of accuracy
- Region monitoring:
    - Monitor distinct regions of interest
    - Generate location events when user enters or leaves those regions
- [Beacon](https://developer.apple.com/documentation/corelocation/ranging_for_beacons) ranging: 
    - Detect and locate nearby beacons
- Compass headings:
    - Report heading changes from onboard compass

## [Location Authorization](https://developer.apple.com/documentation/corelocation/choosing_the_location_services_authorization_to_request)

- Privacy - Location Always and When in Use Usage Description
    - NSLocationAlwaysAndWhenInUseUsageDescription
- Privacy - Location When in Use Usage Description
    - NSLocationWhenInUseUsageDescription

## Resources

- [User Location](https://developer.apple.com/documentation/corelocation/getting_the_user_s_location)
- [Add Location Services](https://developer.apple.com/documentation/corelocation/adding_location_services_to_your_app)
- [Request Location Authorization](https://developer.apple.com/documentation/corelocation/requesting_authorization_for_location_services)

