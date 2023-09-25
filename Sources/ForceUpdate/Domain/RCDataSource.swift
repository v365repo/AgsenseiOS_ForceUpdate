//
//  RCValues.swift
//  AgSense
//
//  Created by Chandra Koppuravuri on 01/08/22.
//  Copyright © 2022 SajWorks, LLC. All rights reserved.
//

import Foundation

enum ValueKey: String {
    case app_forceupdate_json
}

@objcMembers
@objc public class RCDataSource: NSObject {
    
    public static let sharedInstance = RCDataSource()
    
    var appConfig: RCAppConfig?
    
    public var isNewVersionAvailable: Bool {
        get {
            guard let appVerion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String, let appStoreVersion = self.appConfig?.forceUpdate.minAppVersion else { return false }
            
            return appVerion.versionCompare(appStoreVersion) == .orderedAscending
        }
    }
    
    public var iscurrentVersionIsLessThanMaxVersions: Bool {
        get {
            guard let appVerion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String, let maxStoreVersion = self.appConfig?.forceUpdate.maxAppVersion else { return false }
            return appVerion.versionCompare(maxStoreVersion) == .orderedAscending
        }
    }
    
    public var canLogoutWithUpdate: Bool {
        return self.appConfig?.forceUpdate.isForceLogout ?? false
    }
    
    public var isForceLogoutEnable: Bool {
        return self.appConfig?.forcelogout?.isForceLogout ?? false
    }
    
    public var getAppVersion: String {
        return self.appConfig?.forceUpdate.minAppVersion ?? ""
    }
    
    private override init() {
        super.init()
    }
    
    public func fetchCloudValues(_ callback: @escaping ()->Void) {
        
        FirebaseRemoteConfigService().fetchRemoteConfigurationData { [weak self] result in
            
            switch result {
                
            case .success(let appInfo):
                // Success
                self?.appConfig = appInfo
                
                // Switch to main thread and execute the closure
                DispatchQueue.main.async {
                   callback()
                }

            case .failure(let error):
                // Failure
                print(error)
            }
        }
    }
}
