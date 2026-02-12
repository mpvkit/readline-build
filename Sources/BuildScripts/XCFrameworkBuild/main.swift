import Foundation
import BuildShared

do {
    let options = try BuildRunner.performCommand()

    try BuildReadline(options: options).buildALL()
} catch {
    print(error.localizedDescription)
    exit(1)
}


enum Library: String, CaseIterable, BuildLibrary {
    case readline
    var version: String {
        switch self {
        case .readline:
            return "readline-8.3"
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
                    url: "https://github.com/mpvkit/readline-build/releases/download/\(BuildRunner.options!.releaseVersion)/readline.xcframework.zip",
                    checksum: "https://github.com/mpvkit/readline-build/releases/download/\(BuildRunner.options!.releaseVersion)/readline.xcframework.checksum.txt"
                ),
            ]
        }
    }
}



private class BuildReadline: BaseBuild {
    init(options: ArgumentOptions) {
        super.init(library: Library.readline, options: options)
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
