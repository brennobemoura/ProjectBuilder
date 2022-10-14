//
//  File.swift
//  
//
//  Created by onnerb on 13/10/22.
//

import Foundation

public enum Platform {
    case iOS(iOSVersion)
    case macOS(MacOSVersion)
    case tvOS(TVOSVersion)
    case watchOS(WatchOSVersion)
}

extension Platform: CustomStringConvertible {

    public var description: String {
        switch self {
        case .iOS(let version):
            return ".iOS(.\(version.rawValue))"
        case .macOS(let version):
            return ".macOS(.\(version.rawValue))"
        case .tvOS(let version):
            return ".tvOS(.\(version.rawValue))"
        case .watchOS(let version):
            return ".watchOS(.\(version.rawValue))"
        }
    }
}
