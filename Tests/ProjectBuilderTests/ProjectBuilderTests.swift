import XCTest
@testable import ProjectBuilder

struct AppProject: ProjectDescription {

    let output = "~/Desktop"

    var body: Project {
        Project(
            name: "SuperApp",
            swift: "5.7",
            platforms: [.iOS(.v13)],
            packages: [
                .package("Injector"),

                .package("Tools"),

                .package(
                    name: "DesignSystem",
                    url: "www.github.com/apple/design-system",
                    from: "1.0.0"
                ),

                .package(
                    name: "Domain",
                    basePath: "Core",
                    dependencies: ["Injector", "Tools"]
                ),

                .package(
                    name: "AppData",
                    basePath: "Core",
                    dependencies: ["Injector", "Tools", "Domain"]
                ),

                .package(
                    name: "Networking",
                    basePath: "Core",
                    dependencies: ["Injector", "Tools", "Domain", "AppData"]
                ),

                .package(
                    name: "Storage",
                    basePath: "Core",
                    dependencies: ["Injector", "Tools", "Domain", "AppData"]
                ),

                .package(
                    name: "IntegrationSDK",
                    basePath: "Core",
                    dependencies: ["Injector", "Tools", "Domain", "AppData"]
                ),

                .package(
                    name: "AppFeature",
                    basePath: "Feature",
                    dependencies: ["Injector", "Tools", "DesignSystem", "Domain"]
                ),

                .package(
                    name: "App",
                    dependencies: [
                        "Injector",
                        "Tools",
                        "DesignSystem",
                        "Domain",
                        "AppData",
                        "Networking",
                        "Storage",
                        "IntegrationSDK",
                        "AppFeature"
                    ]
                )
            ]
        )
    }
}

final class ProjectBuilderTests: XCTestCase {
    func testExample() throws {
        
    }
}
