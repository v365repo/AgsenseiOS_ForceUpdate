//
//  RCService.swift
//  AgSense
//
//  Created by Chandra Koppuravuri on 07/08/22.
//  Copyright © 2022 SajWorks, LLC. All rights reserved.
//

import Foundation
import Firebase

final class FirebaseRemoteConfigService: NSObject {
    
    typealias Handler = (Result<RCAppConfig, Error>) -> Void
    
    func fetchRemoteConfigurationData(completionHandler: @escaping Handler) {
        
        // WARNING: Only for debug
        activateDebugMode()
        
        RemoteConfig.remoteConfig().fetch { status, error in
            
            if let error = error {
                completionHandler(.failure(error))
                return
            }
            
            RemoteConfig.remoteConfig().activate { _, _ in
                
                let value = RemoteConfig.remoteConfig().configValue(forKey: ValueKey.app_forceupdate_json.rawValue)

                do {
                    let appInfo = try JSONDecoder().decode(RCApp.self, from: value.dataValue).v365
                    completionHandler(.success(appInfo))
                } catch {
                    print("Failed to decode JSON")
                    completionHandler(.failure(error))
                }
            }
        }
    }
    
    private func activateDebugMode() {
        let settings = RemoteConfigSettings()
        // WARNING: Only for debug
        settings.minimumFetchInterval = 0
        //settings.minimumFetchInterval = 43200
        RemoteConfig.remoteConfig().configSettings = settings
    }
}
