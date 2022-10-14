//
//  ProjectDescription.swift
//  
//
//  Created by onnerb on 13/10/22.
//

import Foundation

public protocol ProjectDescription {

    init()

    var output: String { get }

    var body: Project { get }
}

extension ProjectDescription {

    public static func main() {
        Resolver(description: Self()).run()
    }
}

struct Resolver {

    let output: String
    let project: Project

    init(description: ProjectDescription) {
        self.project = description.body
        self.output = description.output
    }

    func run() {
        for package in project.packages.projects {
            packageFile(for: package)
        }
    }
}

extension Resolver {

    func packageFile(for package: Package.Project) -> String {
        """
        // swift-tools-version: \(project.swift)
        // The swift-tools-version declares the minimum version of Swift required to build this package.

        import PackageDescription

        let package = Package(
            name: "\(package.name)",
            platforms: [\(project.platforms.map(\.description).joined(separator: ", "))],
            products: [
                .library(
                    name: "\(package.name)",
                    targets: ["\(package.name)"]
                )
            ],
            dependencies: [\(packages(for: package))],
            targets: [
                .target(
                    name: "\(package.name)",
                    dependencies: [\(products(for: package))]
                ),
                .testTarget(
                    name: "\(package.name)Tests",
                    dependencies: ["\(package.name)"]
                )
            ]
        )
        """
    }
}

extension Resolver {

    func packages(for package: Package.Project) -> String {
        package.dependencies.map { dependency in
            guard let dependency = project.packages.first(where: { $0.name == dependency }) else {
                fatalError()
            }

            return dependency
        }.joined(separator: ",\n")
    }

    func products(for package: Package.Project) -> String {
        fatalError()
    }
}
