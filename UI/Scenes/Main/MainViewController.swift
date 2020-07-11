import Foundation
import UIKit
import Presentation
import Domain
import Kingfisher

public final class MainViewController: UIViewController, Storyboarded {
    
    var pokemons: MainViewModel?
    var pokemonArray = [ResultsViewModel?]()
    var pokemonArrayFiltered = [ResultsViewModel?]()
    var searchController: UISearchController!
    var searchActive : Bool = false
    var isFinalToLoad : Bool = false
    let URLToStop: String = "https://pokeapi.co/api/v2/pokemon?offset=780&limit=20"
    let lastURL: String = "https://pokeapi.co/api/v2/pokemon?offset=780&limit=27"
    
    public var get: ((_ url: String) -> Void?)?
    public var detailViewController: DetailViewController?
    
    @IBOutlet weak var MainViewController: UIActivityIndicatorView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardOnTap()
        get?("https://pokeapi.co/api/v2/pokemon")
    }
    
}

extension MainViewController: LoadingView {
    public func display(viewModel: LoadingViewModel) {
        if viewModel.isLoading {
            view.isUserInteractionEnabled = false
            loadingIndicator?.startAnimating()
        } else {
            view.isUserInteractionEnabled = true
            loadingIndicator?.stopAnimating()
        }
    }
}

extension MainViewController: AlertView {
    public func showMessage(viewModel: AlertViewModel) {
        let alert = UIAlertController(title: viewModel.title, message: viewModel.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true)
    }
}

extension MainViewController: MainView {
    public func presentList(viewModel: MainViewModel?) {
        self.pokemons = viewModel
        self.pokemonArray.append(contentsOf: (viewModel?.results)!)
        self.collectionView.reloadData()
        
    }
}

extension MainViewController: UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {}
    
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        search(searchBar: searchBar, textDidChange: nil)
    }
    
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        search(searchBar: searchBar, textDidChange: searchText)
    }
    
    func search(searchBar: UISearchBar, textDidChange searchText: String?) {
        self.pokemonArrayFiltered.removeAll()
        if !searchBar.text!.isEmpty {
            self.searchActive = true
            self.isFinalToLoad = true
            for item in self.pokemonArray {
                if let name = item?.name!.lowercased() {
                    if ((name.contains(searchBar.text!.lowercased()))) {
                        self.pokemonArrayFiltered.append(item)
                    }
                }
                if let idToSearch = Int(searchBar.text!) {
                    if let url = item?.url!.lowercased() {
                        let id = Int(url.split(separator: "/").last!)
                        if id == idToSearch {
                            self.pokemonArrayFiltered.append(item)
                        }
                    }
                }
            }
            if (searchBar.text!.isEmpty) {
                self.pokemonArrayFiltered = self.pokemonArray
            }
        } else {
            self.searchActive = false
            self.isFinalToLoad = false
        }
        
        self.collectionView.reloadData()
        
    }
    
    public func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true
    }

    public func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false
    }
}
