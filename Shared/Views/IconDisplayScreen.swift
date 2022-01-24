import SwiftUI

/*
 
 Untested
 
 */
struct IconDisplayScreen: View {
    var body: some View {
        VStack {
            Image(systemName: "airplane.circle")
                .font(.system(size: 56.0))
            Image(systemName: "tram.circle")
                .font(.system(size: 56.0))
            Image(systemName: "car.circle")
                .font(.system(size: 56.0))
        }
        .navigationTitle("Icons")
    }
}

#if !TESTING
struct IconDisplayScreen_Previews: PreviewProvider {
    static var previews: some View {
        IconDisplayScreen()
    }
}
#endif
