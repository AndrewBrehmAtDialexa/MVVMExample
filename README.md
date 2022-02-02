# MVVMExample
## PURPOSE
* An example SwiftUI project to demo MVVM, Unit Testing, and Snapshot Testing.
* A resource to pull Base files and extensions for future projects.

## Dependencies
 (NOTE: these dependencies are also available via Carthage and Swift Package Manager)

### In UnitTest target (Using CocoaPods) 
* pod 'Quick' [link](https://cocoapods.org/pods/Quick)
* pod 'Nimble' (Quick and Nimble are used for writing easily readable tests very fast) [link](https://cocoapods.org/pods/Nimble)
* pod 'ViewInspector' (allows UnitTests to inspect and test attributes and methods on SwiftUI views and their children) [link](https://cocoapods.org/pods/ViewInspector)

### In Snapshot Test target (Using CocoaPods)
* pod 'SnapshotTesting' [link](https://cocoapods.org/pods/SnapshotTesting)

## Unit Testing Setup
* Create a new Unit Test Target in project (NOTE: The default one that starts with a new project is a UI Test Target).
* NOTE: All files created from this point on (unless specified) will be inside the Unit Test Target.
* Add pods (Quick, Nimble, ViewInspector).
* Create an extension file to extend your SwiftUI Views as Inspectable [EXAMPLE](https://github.com/AndrewBrehmAtDialexa/MVVMExample/blob/master/MVVMExampleTests/ViewInspector/InspectableView%2BExtensions.swift)



GitIgnore
* add __Snapshots__/failures

Known Limitations/Issues
* Landscape snapshots are unreliable. swift-snapshot-testing Dependency is aware of it and this will more than likely improve with future releases.
