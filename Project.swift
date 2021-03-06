import ProjectDescription

let projectName = "SMUP"
let orginazationIden = "baegteun"

let project = Project(
    name: projectName,
    organizationName: orginazationIden,
    targets: [
        Target(
            name: "\(projectName)",
            platform: .iOS,
            product: .app,
            bundleId: "\(orginazationIden).\(projectName)",
            deploymentTarget: .iOS(targetVersion: "13.0", devices: [.iphone, .ipad]),
            infoPlist: .file(path: Path("Target/Support/Info.plist")),
            sources: ["Target/Source/**"],
            resources: ["Target/Resource/**"],
            entitlements: Path("Target/Support/\(projectName).entitlements")
        ),
        Target(
            name: "\(projectName)Test",
            platform: .iOS,
            product: .unitTests,
            bundleId: "\(orginazationIden).\(projectName)Test",
            deploymentTarget: .iOS(targetVersion: "13.0", devices: [.iphone, .ipad]),
            infoPlist: .default,
            sources: ["TargetTest/Tests/**"],
            dependencies: [
                .target(name: projectName)
            ]
        )
    ]
)
