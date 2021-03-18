import Foundation
import UIKit

class RecipeCell:  UITableViewCell {
    
    var viewModel: RecipeCellViewModel! {
        didSet {
            updateCellLayout()
        }
    }
    
    @IBOutlet weak var lblRecipeName: UILabel!
    @IBOutlet weak var lblRecipeIngredients: UILabel!
    
    func updateCellLayout() {
        lblRecipeName.text = viewModel.recipeName
        lblRecipeIngredients.text = viewModel.recipeIngredients
    }
    
    static var identifier : String {
        return String(describing: self)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        lblRecipeName.text = ""
        lblRecipeIngredients.text = ""
    }
}
