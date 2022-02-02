# MVVMExample
An example project to demo MVVM and Unit Testing.

Dependencies (in UnitTest target) Using CocoaPods (NOTE: these dependencies are also available via Carthage and Swift Package Manager)
* pod 'Quick'
* pod 'Nimble' (Quick and Nimble are used for writing easily readable tests very fast)
* pod 'ViewInspector' (allows UnitTests to inspect and test attributes and methods on SwiftUI views and their children)

Known Limitations/Issues
* Landscape snapshots are unreliable. swift-snapshot-testing Dependency is aware of it and this will more than likely improve with future releases.
