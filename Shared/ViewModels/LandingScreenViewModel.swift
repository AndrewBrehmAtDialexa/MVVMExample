import Foundation
import SwiftUI

class LandingScreenViewModel: ObservableObject {
    
    @Published var buttonAText = "Blue Button"
    @Published var buttonBText = "Red Button"
    @Published var buttonABackground = Color(.blue)
    @Published var buttonBBackground = Color(.red)
    
    var iconDisplayScreen = IconDisplayScreen()
    
    func buttonATapped() {
        DispatchQueue.main.async {
            self.buttonAText = "TAPPED A"
            self.buttonABackground = .black
        }
    }
    
    func buttonBTapped() {
        DispatchQueue.main.async {
            self.buttonBText = "TAPPED B"
            self.buttonBBackground = .yellow
        }
    }
    
    func navLinkADestination() -> IconDisplayScreen {
        return iconDisplayScreen
    }
}
