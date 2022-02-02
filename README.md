# MVVMExample
## PURPOSE
* An example SwiftUI project to demo MVVM, Unit Testing, and Snapshot Testing.
* Demonstrate that SwiftUI views can be tested using Quick / Nimble
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
* Create an extension file to extend your SwiftUI Views as Inspectable [EXAMPLE](/MVVMExampleTests/ViewInspector/InspectableView%2BExtensions.swift)
* You may want to copy / use the extension file created in this project to make fetching view attributes easier [EXAMPLE](/MVVMExampleTests/ViewInspector/Inspection%2BExtensions.swift)

## Unit Testing Usage
* ViewInspector has a few different ways to get view children.
* This example adds a ```.id()``` to each element in the view hierarchy to make it more clear. However, this is not necessary.
* When creating a variable for an element it must be type cast as an ```InspectableView``` with a type of ```KnownViewType.Type```.
  * EXAMPLE: 

If you were getting a ```Text``` SwiftUI view you would create the variable as ```var someText: InspectableView<ViewType.Text>?```
and


GitIgnore
* add __Snapshots__/failures

Known Limitations/Issues
* Landscape snapshots are unreliable. swift-snapshot-testing Dependency is aware of it and this will more than likely improve with future releases.
