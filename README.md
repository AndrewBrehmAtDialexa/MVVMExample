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
* Create a new Unit Test Target (Unit Test Bundle) in project (NOTE: The default one that starts with a new project is a UI Test Target).
* NOTE: All files created from this point on (unless specified) will be inside the Unit Test Target.
* Add pods (Quick, Nimble, ViewInspector). [Podfile Example](/Podfile)
* Create an extension file to extend your SwiftUI Views as Inspectable [EXAMPLE](/MVVMExampleTests/ViewInspector/InspectableView%2BExtensions.swift)
  * Why?... This allows you to inject a mock data into @State, @Binding, etc. If you don't have any need to alter these @ vars (as seen in the [LandingScreen](/Shared/Views/Screens/LandingScreen.swift)) then don't add it. But a view that needs to alter @ vars to test (like the [MovieSearchScreen](/Shared/Views/Screens/MovieSearchScreen.swift))requires it.
  * Also why... It allows you to make custom Views and place them inside other views and inspect them. (see the usage of the custom view MovieListView in [MovieSearchScreen](/Shared/Views/Screens/MovieSearchScreen.swift))
* You may want to copy / use the extension file created in this project to make fetching view attributes easier [EXAMPLE](/MVVMExampleTests/ViewInspector/Inspection%2BExtensions.swift)

## Unit Testing Usage (basic)
* ViewInspector has a few different ways to get view children.
* This example adds a ```.id()``` to each element in the view hierarchy to make it more clear. However, this is not necessary.
* When creating a variable for an element it must be type cast as an ```InspectableView``` with a type of ```KnownViewType.Type```.
  * EXAMPLE: 
  * 
  * If you were getting a ```Text``` SwiftUI view (with an ```.id("myText")```you would create the variable as ```var someText: InspectableView<ViewType.Text>?```.
  * You would instantiate the test variable as ```someText = try uut?.body.inspect().find(ViewType.Text.self, relation: .child, where: { try $0.id() as! String == "myText"})```
  * -OR- (using the mentioned extension file above) you would call ```someText = uut?.findChild(type: ViewType.Text.self, withId: "myText")```
* Using ViewInspector you can test interactions (such as ```.tap()```) as well as inspect various attributes (such as ```.attributes().foregroundColor()```)

## Unit Testing Usage (Injection)
As mentioned in the setup above, to alter @State or @Binding vars in a View you have to make it conform to the ViewInspector's ```Inspectable``` Protocol.
Injection Process:
* Add the View as an extension using Inspectable Protocol ```extension MovieListView: Inspectable { }```
* Inside that view

### ViewInspector Considerations
* Not ALL SwiftUI APIs are fully covered (...yet)
* A list of covered and under development APIs / attributes is at ViewInspector's github repo [View Inspector readiness list](https://github.com/nalexn/ViewInspector/blob/master/readiness.md)
* However, this is not a major factor since its in active development / improvement, and anything that can't currently be tested could be tested via Snapshot Testing (below)

## Snapshot Testing Setup
* Create a new Snapshot Test Target (Unit Test Bundle)
* NOTE: All files created from this point on (unless specified) will be inside the Snapshot Test Target.
* Add pod (SnapshotTesting) [Podfile Example](/Podfile)
* 

GitIgnore
* add __Snapshots__/failures

Known Limitations/Issues
* Landscape snapshots are unreliable. swift-snapshot-testing Dependency is aware of it and this will more than likely improve with future releases.
