import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appCoordintor: AppCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let appWindow = UIWindow(frame: UIScreen.main.bounds)
        let navController = UINavigationController()

        self.appCoordintor = AppCoordinator(navigationController: navController)
        guard let appCoordinator = self.appCoordintor else { return false }
        appCoordinator.start()

        appWindow.rootViewController = navController
        appWindow.makeKeyAndVisible()

        window = appWindow
        
        return true
    }
}
