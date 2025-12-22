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
            url: "https://github.com/mpvkit/readline-build/releases/download/8.3.0/readline.xcframework.zip",
            checksum: "9d291fa6daf226c6d54457bb5656b00a018b9d356b5bfafb65eb9af06c611d35"
        ),
        //AUTO_GENERATE_TARGETS_END//
    ]
)