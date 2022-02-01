import SnapshotTesting
import XCTest
@testable import MVVMExample

class BaseSnapshotTest: XCTestCase {
    override func setUp() {
        super.setUp()
        
        cleanUpFailureFolders()
    }
    
    override func record(_ issue: XCTIssue) {
        super.record(issue)
        
        saveDiffImage()
    }
    
    private func saveDiffImage() {
        let fileMethodName = self.description.components(separatedBy: " ")
        if let testCaseName = fileMethodName.first?.sanitized(),
           let methodName = fileMethodName.last?.sanitized(),
           let failureSnapshotDirPath = ProcessInfo.processInfo.environment["SNAPSHOT_ARTIFACTS"] {
            
            let failureSnapshotDirUrl = URL(fileURLWithPath: failureSnapshotDirPath, isDirectory: true)
            let snapshotDirUrl = failureSnapshotDirUrl.deletingLastPathComponent()
            
            let failingImageUrl = failureSnapshotDirUrl.appendingPathComponent("\(testCaseName)/\(methodName).1.png")
            let baselineImageUrl = snapshotDirUrl.appendingPathComponent("\(testCaseName)/\(methodName).1.png")
            
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
                let filename = failureSnapshotDirUrl.appendingPathComponent("\(testCaseName)/\(methodName).DIFF.png")
                try? diffData.write(to: filename)
            }
        }
    }
    
    private func cleanUpFailureFolders() {
        let fileMethodName = self.description.components(separatedBy: " ")
        if let testCaseName = fileMethodName.first?.sanitized(),
           let methodName = fileMethodName.last?.sanitized(),
           let failureSnapshotDirPath = ProcessInfo.processInfo.environment["SNAPSHOT_ARTIFACTS"] {
            
            let failImagePath = "\(failureSnapshotDirPath)/\(testCaseName)/\(methodName).1.png"
            let diffImagePath = "\(failureSnapshotDirPath)/\(testCaseName)/\(methodName).DIFF.png"
            
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
            print("File does not exist")
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
        
        if let failureSnapshotDirPath = ProcessInfo.processInfo.environment["SNAPSHOT_ARTIFACTS"],
        !hasContentIn(directory: failureSnapshotDirPath) {
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
}
