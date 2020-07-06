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
    
    public var get: ((_ url: String) -> Void?)?
    
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

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(searchActive) {
            return self.pokemonArrayFiltered.count
        } else if self.pokemons?.results != nil {
            return self.pokemonArray.count
        }
        return 0
    }
        
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  50
        let collectionViewSize = collectionView.frame.size.width - padding
        return CGSize(width: collectionViewSize/3, height: collectionViewSize/3)
    }
        
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if !searchActive {
            if !isFinalToLoad {
                
                print(indexPath.item)
                print(self.pokemonArray.count - 4)
                
                if indexPath.item == self.pokemonArray.count - 4 && self.pokemonArray.count < (self.pokemons?.count)! {
                    if (!(self.pokemons?.next!.elementsEqual("https://pokeapi.co/api/v2/pokemon?offset=780&limit=20"))!) {
                        get?((self.pokemons?.next!)!)
                    } else {
                        get?("https://pokeapi.co/api/v2/pokemon?offset=780&limit=27")
                        self.isFinalToLoad = true
                    }
                }
            }
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:  "cell", for: indexPath as IndexPath) as!  CollectionViewCell
        if searchActive {
            cell.label.text = self.pokemonArrayFiltered[indexPath.item]?.name
            let url = (self.pokemonArrayFiltered[indexPath.item]?.url)!
            let id = String(format: "%03d", Int(url.split(separator: "/").last!)!)
            let imageUrl = URL(string: "https://assets.pokemon.com/assets/cms2/img/pokedex/full/\(id).png")!
            cell.imageView.kf.setImage(with: imageUrl)
        } else {
            if let name = self.pokemonArray[indexPath.item]?.name {
                cell.label.text = name
            }
            if let url = self.pokemonArray[indexPath.item]?.url {
                let id = String(format: "%03d", Int(url.split(separator: "/").last!)!)
                let imageUrl = URL(string: "https://assets.pokemon.com/assets/cms2/img/pokedex/full/\(id).png")!
                cell.imageView.kf.setImage(with: imageUrl)
            }
        }
                        
        cell.backgroundColor = UIColor.cyan
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 8
        
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    /*let newViewController = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        if searchActive {
            let url = (self.pokemonArrayFiltered[indexPath.item]?.url)!
            let id = Int(url.split(separator: "/").last!)!
            newViewController.id = id
        } else {
            let url = (self.pokemonArray[indexPath.item]?.url)!
            let id = Int(url.split(separator: "/").last!)!
            newViewController.id = id
        }
        newViewController.transitioningDelegate = self
        present(newViewController, animated: true, completion: nil)*/
    }
    
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let searchView: UICollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SearchBar", for: indexPath)
        return searchView
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
