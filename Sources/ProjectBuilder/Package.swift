//
//  File.swift
//  
//
//  Created by onnerb on 13/10/22.
//

import Foundation

public struct Package {

    fileprivate let type: PackageType

    private init(_ type: PackageType) {
        self.type = type
    }
}

extension Package {

    var name: String {
        switch type {
        case .repository(let repository):
            if let name = repository.name {
                return name
            }

            guard let name = repository.url.split(separator: "/").last?.split(separator: ".").first else {
                fatalError()
            }

            return "\(name)"
        case .project(let project):
            return project.name
        case .local(let local):
            return local.name
        }
    }
}

extension Package {

    public static func package(name: String, path: String) -> Package {
        .init(.local(
            Local(
                name: name,
                path: path
            )
        ))
    }

    public static func package(_ name: String) -> Package {
        package(name: name, path: name)
    }

    public static func package(name: String, dependencies: [String]) -> Package {
        .init(.project(
            Project(
                name: name,
                basePath: nil,
                dependencies: dependencies
            )
        ))
    }

    public static func package(name: String, basePath: String, dependencies: [String]) -> Package {
        .init(.project(
            Project(
                name: name,
                basePath: basePath,
                dependencies: dependencies
            )
        ))
    }

    public static func package(name: String, url: String, from version: String) -> Package {
        .init(.repository(
            Repository(
                name: name,
                url: url,
                version: version
            )
        ))
    }

    public static func package(url: String, from version: String) -> Package {
        .init(.repository(
            Repository(
                name: nil,
                url: url,
                version: version
            )
        ))
    }
}

extension Package {

    struct Local {
        let name: String
        let path: String
    }

    struct Repository {
        let name: String?
        let url: String
        let version: String
    }

    struct Project {
        let name: String
        let basePath: String?
        let dependencies: [String]
    }
}

enum PackageType {
    case local(Package.Local)
    case repository(Package.Repository)
    case project(Package.Project)
}

extension Array where Element == Package {

    var projects: [Package.Project] {
        compactMap {
            if case .project(let project) = $0.type {
                return project
            }

            return nil
        }
    }
}
