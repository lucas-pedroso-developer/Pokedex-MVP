import UIKit
import Kingfisher

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
                
                if indexPath.item == self.pokemonArray.count - 4 && self.pokemonArray.count < (self.pokemons?.count)! {
                    
                    if (!(self.pokemons?.next!.elementsEqual(self.URLToStop))!) {
                        get?((self.pokemons?.next!)!)
                    } else {
                        get?(self.lastURL)
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
        var idToSend: Int = 0
        if searchActive {
            let url = (self.pokemonArrayFiltered[indexPath.item]?.url)!
            idToSend = Int(url.split(separator: "/").last!)!
        } else {
            let url = (self.pokemonArray[indexPath.item]?.url)!
            idToSend = Int(url.split(separator: "/").last!)!
        }
        self.detailViewController?.id = idToSend
        present(self.detailViewController!, animated: true, completion: nil)
    }
    
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let searchView: UICollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SearchBar", for: indexPath)
        return searchView
    }
    
}
