import SwiftUI

@main
struct MVVMExampleApp: App {
    
    init() {
        UINavigationBar.appearance().backgroundColor = .lightGray
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .foregroundColor: UIColor.white]
    }
    
    var body: some Scene {
        WindowGroup {
            LandingScreen()
        }
    }
}
