//
//  String+Extension.swift
//  Valley365
//
//  Created by Chandra Koppuravuri on 05/08/22.
//  Copyright © 2022 SajWorks, LLC. All rights reserved.
//

import Foundation

extension String {
    
    // This method will compare the 2 version strings
    func versionCompare(_ otherVersion: String) -> ComparisonResult {
        let versionDelimiter = "."
        
        // Split the version by period
        var versionComponents = self.components(separatedBy: versionDelimiter)
        var otherVersionComponents = otherVersion.components(separatedBy: versionDelimiter)

        // Find the difference of digit that we will zero pad
        let zeroDiff = versionComponents.count - otherVersionComponents.count

        if zeroDiff == 0 {
            // Same format, compare normally
            return self.compare(otherVersion, options: .numeric)
        } else {
            let zeros = Array(repeating: "0", count: abs(zeroDiff))
            if zeroDiff > 0 {
                otherVersionComponents.append(contentsOf: zeros)
            } else {
                versionComponents.append(contentsOf: zeros)
            }
            return versionComponents.joined(separator: versionDelimiter)
                .compare(otherVersionComponents.joined(separator: versionDelimiter), options: .numeric)
        }
    }
}
