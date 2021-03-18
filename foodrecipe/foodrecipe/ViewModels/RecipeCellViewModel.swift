import Foundation
import UIKit

class RecipeCellViewModel {
    private let model: Recipe
    
    init(model: Recipe) {
        self.model = model
    }
    
    var recipeName: String {
        return model.name
    }
    
    var recipeIngredients: String {
        return model.ingredients.map{ $0.lowercased() }.joined(separator: ", ")
    }
}
