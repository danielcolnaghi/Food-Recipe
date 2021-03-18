import XCTest
@testable import foodrecipe

class foodrecipeTests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }
    
    func testAppCoordinator() throws {
        let nav = UINavigationController()
        let appCoordinator = AppCoordinator(navigationController: nav)
        appCoordinator.start()
        
        XCTAssertEqual(nav.viewControllers.first?.nibName, "CookingViewController")
    }
    
    func testRecipe() throws {
        let tomatoPasta = Recipe(name: "Tomato pasta", ingredients: ["tomato", "pasta", "water"])
        let tomatoPastaEqual = Recipe(name: "Tomato pasta", ingredients: ["tomato", "pasta", "water"])
        let tomatoPastaWrongName = Recipe(name: "Tomato PASTA", ingredients: ["tomato", "pasta", "water"])
        let tomatoPastaWrongIng = Recipe(name: "Tomato pasta", ingredients: ["TOMATE", "pasta", "water"])
        
        XCTAssertEqual(tomatoPasta, tomatoPastaEqual)
        XCTAssertNotEqual(tomatoPasta, tomatoPastaWrongName, "Wrong pasta!")
        XCTAssertNotEqual(tomatoPasta, tomatoPastaWrongIng, "Wrong ingreditens!")
    }

    func testRecipeDB() throws {
        let tomatoPasta = Recipe(name: "Tomato pasta", ingredients: ["tomato", "pasta", "water"])
        let chickenTikkaMasala = Recipe(name: "Chicken tikka masala", ingredients: ["chicken", "butter", "onion"])
        let cheesecake = Recipe(name: "Cheesecake", ingredients: ["biscuit", "butter", "sugar"])
        let chocolateBrownie = Recipe(name: "Chocolate brownie", ingredients: ["chocolate", "butter", "sugar"])
        let meatball = Recipe(name: "Meatball", ingredients: ["Meat", "parmesan", "onion"])
        let meatloaf = Recipe(name: "Meatloaf", ingredients: ["Meat", "egg", "onion"])

        let allRecipes = RecipeDB.shared.loadData()
        
        XCTAssertEqual(allRecipes?.first, tomatoPasta)
        XCTAssertEqual(allRecipes?[1], chickenTikkaMasala)
        XCTAssertEqual(allRecipes?[2], cheesecake)
        XCTAssertEqual(allRecipes?[3], chocolateBrownie)
        XCTAssertEqual(allRecipes?[4], meatball)
        XCTAssertEqual(allRecipes?.last, meatloaf)
    }
    
    func testRecipeCellViewModel() throws {
        let tomatoPasta = Recipe(name: "Tomato pasta", ingredients: ["tomato", "pasta", "water"])
        let cellViewModel = RecipeCellViewModel(model: tomatoPasta)
        
        XCTAssertEqual(cellViewModel.recipeName, "Tomato pasta")
        XCTAssertEqual(cellViewModel.recipeIngredients, "tomato, pasta, water")
    }
    
    func testRecipeCell() throws {
        let cell = RecipeCell()
        let lblName = UILabel()
        let lblIngredients = UILabel()
        cell.lblRecipeName = lblName
        cell.lblRecipeIngredients = lblIngredients
        
        let tomatoPasta = Recipe(name: "Tomato pasta", ingredients: ["tomato", "pasta", "water"])
        let cellViewModel = RecipeCellViewModel(model: tomatoPasta)
        cell.viewModel = cellViewModel
        
        XCTAssertEqual(cell.lblRecipeName.text, "Tomato pasta")
        XCTAssertEqual(cell.lblRecipeIngredients.text, "tomato, pasta, water")
        
        XCTAssertEqual(RecipeCell.identifier, "RecipeCell")
        
        cell.prepareForReuse()
        XCTAssertEqual(cell.lblRecipeName.text, "")
        XCTAssertEqual(cell.lblRecipeName.text, "")
    }

    func testCookingViewModel() throws {
        let api = MokedAPIService()
        let cookingViewModel = CookingViewModel(apiService: api)
        cookingViewModel.start()
        
        XCTAssertEqual(cookingViewModel.recipes.count, 3)

        XCTAssertEqual(cookingViewModel.recipes.first?.name, "Chicken tikka masala")
        XCTAssertEqual(cookingViewModel.recipes[1].name, "Meatball")
        XCTAssertEqual(cookingViewModel.recipes.last?.name, "Meatloaf")
    }
    
    func testPerformanceExample() throws {
        self.measure {
        }
    }

}

class MokedAPIService: APIService {
    
    override func request<T>(router: APIRouter, result: @escaping (Result<T, Error>) -> ()) where T : Decodable {
        var model: [String]
        
        switch router {
        case .getIngredients:
            model = ["Meat", "egg", "onion", "parmesan", "butter", "sugar", "chicken"]
            result(.success((model as? T)!))
        }
    }

}
