import Foundation
import UIKit

final class AppCoordinator {
    
    private let navigationController: UINavigationController
    private let apiService: APIService
    
    init (navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.apiService = APIService()
    }
    
    func start() {
        let viewModel = CookingViewModel(apiService: apiService)
        let homeVC = CookingViewController.loadFromNib()
        homeVC.viewModel = viewModel
        navigationController.pushViewController(homeVC, animated: false)
    }
}
