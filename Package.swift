// swift-tools-version:5.8

import PackageDescription

let package = Package(
    name: "readline",
    platforms: [.macOS(.v10_15), .iOS(.v13), .tvOS(.v13)],
    products: [
        .library(name: "readline", targets: ["_readline"]),
    ],
    targets: [
        // Need a dummy target to embedded correctly.
        // https://github.com/apple/swift-package-manager/issues/6069
        .target(
            name: "_readline",
            dependencies: ["readline"],
            path: "Sources/_Dummy"
        ),
        //AUTO_GENERATE_TARGETS_BEGIN//

        .binaryTarget(
            name: "readline",
            url: "https://github.com/mpvkit/readline-build/releases/download/8.2.0/readline.xcframework.zip",
            checksum: "8f943e65fd4fd8e5227abafc21820ade5870849887c32f19ad440366f9f31d3a"
        ),
        //AUTO_GENERATE_TARGETS_END//
    ]
)