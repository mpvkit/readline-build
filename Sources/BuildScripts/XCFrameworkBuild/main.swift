import Foundation

do {
    let options = try ArgumentOptions.parse(CommandLine.arguments)
    try Build.performCommand(options)

    try BuildReadline().buildALL()
} catch {
    print("ERROR: \(error.localizedDescription)")
    exit(1)
}


enum Library: String, CaseIterable {
    case readline
    var version: String {
        switch self {
        case .readline:
            return "readline-8.2"
        }
    }

    var url: String {
        switch self {
        case .readline:
            return "https://git.savannah.gnu.org/git/readline.git"
        }
    }

    // for generate Package.swift
    var targets : [PackageTarget] {
        switch self {
        case .readline:
            return  [
                .target(
                    name: "readline",
                    url: "https://github.com/mpvkit/readline-build/releases/download/\(BaseBuild.options.releaseVersion)/readline.xcframework.zip",
                    checksum: "https://github.com/mpvkit/readline-build/releases/download/\(BaseBuild.options.releaseVersion)/readline.xcframework.checksum.txt"
                ),
            ]
        }
    }
}


private class BuildReadline: BaseBuild {
    init() {
        super.init(library: .readline)
    }

    override func arguments(platform: PlatformType, arch: ArchType) -> [String] {
        [
            "--enable-static",
            "--disable-shared",
            "--host=\(platform.host(arch: arch))",
            "--prefix=\(thinDir(platform: platform, arch: arch).path)",
        ]
    }
}
