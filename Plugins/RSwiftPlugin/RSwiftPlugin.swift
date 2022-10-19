import Foundation
import PackagePlugin

@main struct RSwiftPlugin: BuildToolPlugin {
    func createBuildCommands(context _: PluginContext, target _: Target) async throws -> [Command] {
        return [
        ]
    }
}

#if canImport(XcodeProjectPlugin)
import XcodeProjectPlugin

extension RSwiftPlugin: XcodeBuildToolPlugin {
    func createBuildCommands(context: XcodePluginContext, target: XcodeTarget) throws -> [Command] {
        let outputPath = context.pluginWorkDirectory
        let outputFilePath = outputPath.appending("R.generated.swift")
        
        /*
         let buildProductsDir = context.pluginWorkDirectory
         .removingLastComponent()
         .removingLastComponent()
         .removingLastComponent()
         .removingLastComponent()
         .removingLastComponent()
         .appending("Build")
         .appending("Products")
         .appending("ProdDebug-iphonesimulator") // ??
         .string
         */
        
        return [
            .prebuildCommand(
                displayName: "running rswift",
                executable: try context.tool(named: "rswift").path,
                arguments: [
                    "generate",
                    "\(outputFilePath.string)",
                ],
                environment: [
                    "PROJECT_DIR": "\(context.xcodeProject.directory.string)",
                    "TARGET_NAME": "\(target.displayName)",
                    "BUILT_PRODUCTS_DIR": "", // "\(buildProductsDir)",
                    "DEVELOPER_DIR": "", // "/Applications/Xcode_14.app/Contents/Developer",
                    "SDKROOT": "", // "/Applications/Xcode_14.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator16.0.sdk",
                    "PLATFORM_DIR": "", // "/Applications/Xcode_14.app/Contents/Developer/Platforms/iPhoneSimulator.platform",
                    "SOURCE_ROOT": "\(context.xcodeProject.directory.string)",
                    "PRODUCT_BUNDLE_IDENTIFIER": "", // "app.bundle.identifier",
                    "PRODUCT_MODULE_NAME": "\(target.displayName)",
                    "PROJECT_FILE_PATH": "\(context.xcodeProject.directory.appending("\(target.displayName).xcodeproj"))",
                ],
                outputFilesDirectory: outputPath
            ),
        ]
    }
}
#endif
