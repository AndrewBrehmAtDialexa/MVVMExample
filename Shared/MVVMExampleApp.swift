import SwiftUI

@main
struct MVVMExampleApp: App {
    
    init() {
        UINavigationBar.appearance().backgroundColor = .lightGray
        UINavigationBar.appearance().prefersLargeTitles = true
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    var body: some Scene {
        WindowGroup {
            LandingScreen()
        }
    }
}
