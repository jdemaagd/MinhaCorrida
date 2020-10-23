# [CloudKit](https://developer.apple.com/icloud/cloudkit/)


## [Dashboard](https://icloud.developer.apple.com/dashboard/)

- Problem: leaking secrets from app (app secrets, api keys, etc.)
- Components: 
    - Web dashboard to manage record types and any public data
    - Set of APIs to transfer data between iCloud and device
- Private databases are protected
- CloudKit vs BaaS (Backend as a Service) 
    - Simplicity: 
        - just register for iOS Developer Program
        - create iCloud account
    - Trust:
        - users can trust privacy/security of data by relying on Apple 
        - insulates user data from developer
    - Cost: no extra cost of running service
- [Errors](https://developer.apple.com/documentation/cloudkit/ckerror)

## Entitlements and Containers

## Data

- Public/Private Databases

## Schema

- Represents high-level objects of a CloudKit container: 
    - Record Types, Indexes, Security Roles, and Subscription Types

## Telemetry

## Usage

## Logs

## API Access

- Provides ability to configure dashboard permissions

## Assets

- Can only exist in CloudKit as attributes on records
    - cannot store then on their own
    - deleting a record will also delete any associated assets
- Retrieving assets can negatively impact performance 
    - because you download assets at same time as rest of record data
    - if your app makes heavy use of assets
    - then you should store a reference to a different type of record that holds just asset

## Resources

- [NSPredicate](https://developer.apple.com/documentation/foundation/nspredicate)
- [NSPredicate Cheatsheet](https://academy.realm.io/posts/nspredicate-cheatsheet/)
- [NSPredicate Blog](https://nshipster.com/nspredicate/)

