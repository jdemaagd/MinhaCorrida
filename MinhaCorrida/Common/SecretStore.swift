//
//  Secrets.swift
//  MinhaCorrida
//
//  Created by Jon DeMaagd on 9/6/20.
//  Copyright © 2020 JON DEMAAGD. All rights reserved.
//

import CloudKit

class SecretStore {
    
    private let id: CKRecord.ID
    private(set) var secretStoreLabel: String?
    
    let key: String
    let value: String
    
    init(record: CKRecord) {
        id = record.recordID
        secretStoreLabel = record["SecretStore"] as? String
        self.key = record["key"] as? String ?? "no key"
        self.value = (record["value"] as? String)!
    }
    
    static func fetchSecrets(_ completion: @escaping (Result<[SecretStore], Error>) -> Void) {
      
        let predicate = NSPredicate(format: "%K == %@", "key", "appSecret")
        let query = CKQuery(recordType: "SecretStore", predicate: predicate)
      
        let container = CKContainer.default()
      
        container.privateCloudDatabase.perform(query, inZoneWith: nil) { results, error in
        
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            
            guard let results = results else {
                DispatchQueue.main.async {
                    let error = NSError(domain: "com.jdemaagd", code: -1, userInfo: [NSLocalizedDescriptionKey: "Could not download secrets"])
                    completion(.failure(error))
                }
                return
            }

            let secrets = results.map(SecretStore.init)
            DispatchQueue.main.async {
                completion(.success(secrets))
            }
        }
    }
}
