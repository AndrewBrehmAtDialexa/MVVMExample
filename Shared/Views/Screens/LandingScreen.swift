import SwiftUI
/*
 
 UI elements
 * VStack
 * Text - various attributes
 * HStack
 * Button
 
 */

struct LandingScreen: View {
    
    @ObservedObject var landingScreenViewModel = LandingScreenViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Text("First Text")
                    .padding()
                    .foregroundColor(.red)
                    .id("screenTextA")
                
                Text("Second Text")
                    .padding(EdgeInsets(top: 30, leading: 30, bottom: 30, trailing: 30))
                    .id("screenTextB")
                
                HStack {
                    Button(
                        action: {
                            landingScreenViewModel.buttonATapped()
                        },
                        label: {
                            Text("\(landingScreenViewModel.buttonAText)")
                                .padding()
                                .foregroundColor(.white)
                                .background(landingScreenViewModel.buttonABackground)
                        })
                        .id("buttonA")
                    
                    Button(
                        action: {
                            landingScreenViewModel.buttonBTapped()
                        },
                        label: {
                            Text(landingScreenViewModel.buttonBText)
                                .padding()
                                .foregroundColor(.white)
                                .background(landingScreenViewModel.buttonBBackground)
                        })
                        .id("buttonB")
                }
                .padding()
                .id("buttonHolder")
                
                NavigationLink(
                    destination: {
                        landingScreenViewModel.navLinkADestination()
                    },
                    label: {
                        Text("Movie List")
                            .padding()
                            .foregroundColor(.white)
                            .background(.green)
                    })
            }
            .navigationTitle("Landing Screen")
            .id("mainVStack")
        }
        .id("navView")
    }
    
    func testingFunc() -> String {
        return "testingFunc called"
    }
}

#if !TESTING
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LandingScreen()
    }
}
#endif
