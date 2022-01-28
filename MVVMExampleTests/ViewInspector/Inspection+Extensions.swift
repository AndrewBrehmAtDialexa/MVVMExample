import ViewInspector
import SwiftUI

extension View {
    func findChild<T>(type viewType: KnownViewType.Type, withId id: String) -> InspectableView<T>? where T: KnownViewType {
        return try? self.body.inspect().find(viewType.self as! T.Type, relation: .child, where: { try $0.id() as! String == id })
    }
    
    func findNavView() -> InspectableView<ViewType.NavigationView>? {
        return try? self.body.inspect().navigationView()
    }
}

extension InspectableView {
    func findChild<T>(type viewType: KnownViewType.Type, withId id: String) -> InspectableView<T>? where T: KnownViewType {
        return try? self.find(viewType.self as! T.Type, where: { try $0.id() as! String == id })
    }
    
    func findNavLink(_ title: String) -> InspectableView<ViewType.NavigationLink>? {
        return try? self.find(navigationLink: title)
    }
}
