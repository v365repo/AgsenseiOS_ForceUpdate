//
//  RCApp.swift
//  AgSense
//
//  Created by Chandra Koppuravuri on 05/08/22.
//  Copyright © 2022 SajWorks, LLC. All rights reserved.
//

import Foundation

struct RCApp: Codable {
    let v365: RCAppConfig
}

struct RCAppConfig: Codable {
    let forceUpdate: AppVersionUpdateModel
    let forcelogout: ForceLogoutModel?
}

struct AppVersionUpdateModel: Codable {
    let minAppVersion: String
    let maxAppVersion: String
    let isForceLogout: Bool
}

struct ForceLogoutModel: Codable {
    let isForceLogout: Bool
}
