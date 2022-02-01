////struct PageViewController: UIViewControllerRepresentable {
////    var controllers: [UIViewController]
////
////    func makeUIViewController(context: Context) -> UIPageViewController {
////        let pageViewController = UIPageViewController(
////            transitionStyle: .scroll,
////            navigationOrientation: .horizontal)
////
////        return pageViewController
////    }
////
////    func updateUIViewController(_ pageViewController: UIPageViewController, context: Context) {
////        pageViewController.setViewControllers(
////            [controllers[0]], direction: .forward, animated: true)
////    }
////
////    class Coordinator: NSObject {
////        var parent: PageViewController
////
////        init(_ pageViewController: PageViewController) {
////            self.parent = pageViewController
////        }
////    }
////}
//
//@testable import MVVMExample
//import SwiftUI
//
//struct LandingScreenViewController: UIViewControllerRepresentable {
//    public typealias UIViewControllerType = UIViewController
//    
//    public func makeUIViewController(context: Context) -> UIViewController {
//        return UIHostingController(rootView: LandingScreen())
//    }
//    
//    public func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
//        //code
//    }
//}
//
////struct MovieSearchScreenViewController: UIViewControllerRepresentable {
////    public typealias UIViewControllerType = UIViewController
////    
////    public func makeUIViewController(context: Context) -> UIViewController {
////        return UIHostingController(rootView: MovieSearchScreen())
////    }
////    
////    public func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
////        //code
////    }
////}
//
////TODO pass generic Type of View
