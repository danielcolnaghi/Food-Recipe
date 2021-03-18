import Foundation
import Combine

final class CookingViewModel {
    
    private let apiService: APIService
    var subscriptions = Set<AnyCancellable>()
    @Published var recipes = [Recipe]()
    
    init(apiService: APIService) {
        self.apiService = apiService
    }
    
    func start() {
        fechData()
    }
    
    private func recipeFilter(ingredients: [String]) {
        guard let allRecipes = RecipeDB.shared.loadData() else { return }
        
        let filtered = allRecipes.filter {
            $0.ingredients.allSatisfy({ ing in
                ingredients.contains(where: { $0.caseInsensitiveCompare(ing) == .orderedSame })
            })
        }
        
        self.recipes = filtered
    }
    
    private func fechData() {
        apiService.request(router: APIRouter.getIngredients) { [weak self] (response: Result<[String], Error>) in
            switch response {
                case let .success(ingredients):
                    self?.recipeFilter(ingredients: ingredients)
                case let .failure(error):
                    debugPrint(error)
            }
        }
    }
}
