import ViewInspector
import SwiftUI

extension View {
    func findChild<T>(type viewType: KnownViewType.Type, withId id: String) -> InspectableView<T>? where T: KnownViewType {
        do {
            return try self.body.inspect().find(viewType.self as! T.Type, relation: .child, where: { try $0.id() as! String == id })
        } catch {
            print("ERROR")
        }
        
        return nil
    }
    
    func findNavView() -> InspectableView<ViewType.NavigationView>? {
        do {
            return try self.body.inspect().navigationView()
        } catch {
            print("ERROR")
        }

        return nil
    }
}

extension InspectableView {
    func findChild<T>(type viewType: KnownViewType.Type, withId id: String) -> InspectableView<T>? where T: KnownViewType {
        do {
            return try self.find(viewType.self as! T.Type, where: { try $0.id() as! String == id })
        } catch {
            print("ERROR")
        }
        
        return nil
    }
    
    func findNavLink(_ title: String) -> InspectableView<ViewType.NavigationLink>? {
        do {
            return try self.find(navigationLink: title)
        } catch {
            print ("ERROR")
        }
        
        return nil
    }
}
