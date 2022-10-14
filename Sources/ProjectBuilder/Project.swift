//
//  File.swift
//  
//
//  Created by onnerb on 13/10/22.
//

import Foundation

public struct Project {
    let name: String
    let swift: String
    let defaultLocalization: String?
    let platforms: [Platform]
    let packages: [Package]

    public init(
        name: String,
        swift: String,
        defaultLocalization: String? = nil,
        platforms: [Platform],
        packages: [Package]
    ) {
        self.name = name
        self.swift = swift
        self.defaultLocalization = defaultLocalization
        self.platforms = platforms
        self.packages = packages
    }
}
