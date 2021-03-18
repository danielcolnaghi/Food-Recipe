import UIKit
import Combine

class CookingViewController: UIViewController {
    var viewModel: CookingViewModel!
    private var bindings = Set<AnyCancellable>()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard viewModel != nil else { fatalError() }
        setup()
    }
    
    private func setup() {
        let cellNib = UINib(nibName: RecipeCell.identifier, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: RecipeCell.identifier)
        setupBinding()
        viewModel.start()
    }
    
    func setupBinding() {
        viewModel.$recipes.receive(on: DispatchQueue.main)
            .sink { (_) in
                self.tableView.reloadData()
            }
            .store(in: &bindings)
    }
}

extension CookingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RecipeCell.identifier, for: indexPath) as? RecipeCell else {
            return UITableViewCell()
        }
        let cellModel = viewModel.recipes[indexPath.row]
        cell.viewModel = RecipeCellViewModel(model: cellModel)
        cell.updateCellLayout()
        return cell
    }
}
