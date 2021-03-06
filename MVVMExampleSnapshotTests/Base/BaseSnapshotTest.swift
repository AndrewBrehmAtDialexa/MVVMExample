import SnapshotTesting
import XCTest
@testable import MVVMExample
import SwiftUI

class BaseSnapshotTest: XCTestCase {
    lazy var fileMethodName = self.description.components(separatedBy: " ")
    lazy var testCaseName = fileMethodName.first?.sanitized() ?? "UNKNOWN"
    lazy var methodName = fileMethodName.last?.sanitized() ?? "UNKNOWN"
    
    /*
     Place the devices you want to test here.
     The String will be the name that appears on the snapshot file.
     The ViewImageConfig is the device type.
     Phones are defaulted to .portrait mode.
     iPads are defaulted to .landscape mode
     */
    private let devicesToTest: [String : ViewImageConfig] = [
        "iPhoneXsMax" : .iPhoneXsMax,
        "iPadPro12_9" : .iPadPro12_9(.portrait),
        "iPhoneSe" : .iPhoneSe
    ]
    
    override func setUp() {
        super.setUp()
        
        cleanUpFailureFolders()
    }
    
    override func record(_ issue: XCTIssue) {
        super.record(issue)
        
        saveDiffImage()
    }
    
    // MARK: - Image Processing
    
    func takeSnapshot<Value>(
        for view: UIHostingController<Value>,
        addToNavigationView addNav: Bool = false,
        clipToComponent clip: Bool = false,
        file: StaticString = #file,
        record recording: Bool = false,
        timeout: TimeInterval = 0,
        line: UInt = #line
    ){
      devicesToTest.forEach { device in
            var navController: UINavigationController?
            var componentSize: CGSize?
            
            if addNav {
                navController = UINavigationController()
                let firstScreen = MockViewController()
                navController?.viewControllers = [firstScreen, view]
                firstScreen.setNavTitle()
            }
            
            if clip, let componentWidth = device.value.size?.width {
                componentSize = CGSize(width: componentWidth, height: view.preferredContentSize.height)
            }
            
            let result = verify(navController ?? view, forDeviceImageConfig: device.value, named: device.key, withComponentSize: componentSize, file: file, record: recording, timeout: timeout)
            guard let message = result else { return }
            XCTFail(message, file: file, line: line)
        }
    }
    
    private func verify(
        _ view: UIViewController,
        forDeviceImageConfig imageConfig: ViewImageConfig,
        named name: String,
        withComponentSize componentSize: CGSize? = nil,
        file: StaticString = #file,
        record recording: Bool = false,
        timeout: TimeInterval = 0
    ) -> String? {
        return verifySnapshot(
            matching: view,
            as: .wait(for: timeout, on: .image(on: imageConfig, size: componentSize)),
            named: name,
            record: recording,
            snapshotDirectory: pathToSnapshotReferenceDir(),
            timeout: timeout,
            file: file,
            testName: methodName
        )
    }
    
    private func diff(_ old: UIImage, _ new: UIImage) -> UIImage {
        let width = max(old.size.width, new.size.width)
        let height = max(old.size.height, new.size.height)
        UIGraphicsBeginImageContextWithOptions(CGSize(width: width, height: height), true, 0)
        new.draw(at: .zero)
        old.draw(at: .zero, blendMode: .difference, alpha: 1)
        let differenceImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return differenceImage
    }
    
    private func saveDiffImage() {
        
        devicesToTest.forEach { device in
            let deviceName = device.key
            let failureSnapshotDirUrl = URL(fileURLWithPath: pathToSnapshotArtifacts(), isDirectory: true)
            let snapshotDirUrl = URL(fileURLWithPath: pathToSnapshotReferenceDir(), isDirectory: true)
            
            let failingImageUrl = failureSnapshotDirUrl.appendingPathComponent("\(testCaseName)/\(methodName).\(deviceName).png")
            let baselineImageUrl = snapshotDirUrl.appendingPathComponent("\(methodName).\(deviceName).png")
            
            guard
                let baseImageData = try? Data(contentsOf: baselineImageUrl),
                let failImagedata = try? Data(contentsOf: failingImageUrl),
                let originalImage = UIImage(data: baseImageData),
                let failureImage = UIImage(data: failImagedata) else {
                    print("ERROR: Image data not found for snapshot")
                    return
                }
            
            
            let diffImage = diff(originalImage, failureImage)
            
            if let diffData = diffImage.pngData() {
                let filename = failureSnapshotDirUrl.appendingPathComponent("\(testCaseName)/\(methodName).\(deviceName)-DIFF.png")
                try? diffData.write(to: filename)
            }
        }
    }
    
    
    // MARK: - File and Directory organization
    
    private func pathToSnapshotReferenceDir() -> String {
        guard let path = ProcessInfo.processInfo.environment["SNAPSHOT_REFERENCE_DIR"] else {
            return "UNKNOWN"
        }
        
        return "\(path)/\(testCaseName)"
    }
    
    private func pathToSnapshotArtifacts() -> String {
        guard let path = ProcessInfo.processInfo.environment["SNAPSHOT_ARTIFACTS"] else {
            return "UNKNOWN"
        }
        
        return path
    }
    
    private func cleanUpFailureFolders() {
        let failureSnapshotDirPath = pathToSnapshotArtifacts()
        devicesToTest.forEach { device in
            let deviceName = device.key
            let failImagePath = "\(failureSnapshotDirPath)/\(testCaseName)/\(methodName).\(deviceName).png"
            let diffImagePath = "\(failureSnapshotDirPath)/\(testCaseName)/\(methodName).\(deviceName)-DIFF.png"
            
            deletefile(atPath: failImagePath)
            deletefile(atPath: diffImagePath)
            
            checkAndDelete(mainDir: failureSnapshotDirPath, andSubDir: testCaseName)
        }
    }
    
    private func deletefile(atPath filePath: String) {
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: filePath) {
            try? fileManager.removeItem(atPath: filePath)
        } else {
            print("File does not exist: ", filePath)
        }
    }
    
    private func checkAndDelete(mainDir main: String, andSubDir sub: String = "") {
        let fullPath = "\(main)/\(sub)"
        if !hasContentIn(directory: fullPath) {
            try? FileManager.default.removeItem(atPath: fullPath)
        }
        
        if !hasContentIn(directory: main) {
            try? FileManager.default.removeItem(atPath: main)
        }
        
        let failureSnapshotDirPath = pathToSnapshotArtifacts()
        if !hasContentIn(directory: failureSnapshotDirPath) {
            try? FileManager.default.removeItem(atPath: failureSnapshotDirPath)
        }
    }
    
    private func hasContentIn(directory dir: String) -> Bool {
        var hasContent = false
        if let url = URL(string: dir),
           let directoryContents = try? FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil),
           directoryContents.count > 0,
           let firstContent = directoryContents.first {
            
            hasContent = !firstContent.lastPathComponent.contains(".DS_Store")
        }
        
        return hasContent
    }
}
