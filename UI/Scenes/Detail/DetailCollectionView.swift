import UIKit

extension DetailViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
                
        if collectionView.tag == 0 {
            if self.types != nil {
                return self.types?.count ?? 0
            }
        } else if collectionView.tag == 1 {
            if self.speciesEvolutionArray.count > 0 {
                return self.speciesEvolutionArray.count
            }
        } else if collectionView.tag == 2 {
            if self.pokemonDetail?.abilities != nil {
                return self.pokemonDetail?.abilities?.count ?? 0
            }
        }
        return 0
    }
                    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier:  "cell", for: indexPath as IndexPath) as! TypeCollectionViewCell
            
            cell.typeButton.setTitle(self.types?[indexPath.item].type?.name, for: .normal)
            cell.typeButton.tag = indexPath.item
            
            cell.backgroundColor = UIColor(named: (self.types?[indexPath.item].type?.name)!)
            cell.layer.borderColor = UIColor.white.cgColor
            cell.layer.borderWidth = 1
            cell.layer.cornerRadius = self.view.bounds.width*3/100
            
            self.pokemonMainColor = UIColor(named: (self.types?[indexPath.item].type?.name)!)
            self.backgroundView.backgroundColor = self.pokemonMainColor
            self.backNavBarButton.tintColor = self.pokemonMainColor
            self.segment.backgroundColor = self.pokemonMainColor
            self.abilityLabel.backgroundColor = self.pokemonMainColor
            self.dataDescriptionLabel.backgroundColor = self.pokemonMainColor
            self.hpProgress.tintColor = self.pokemonMainColor
            self.atackProgress.tintColor = self.pokemonMainColor
            self.defenseProgress.tintColor = self.pokemonMainColor
            self.specialAtackProgress.tintColor = self.pokemonMainColor
            self.specialDefenseProgress.tintColor = self.pokemonMainColor
            self.speedProgress.tintColor = self.pokemonMainColor
            return cell
        } else if collectionView.tag == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier:  "evolutionCell", for: indexPath as IndexPath) as! EvolutionCollectionViewCell
            if let url = self.speciesEvolutionArray[indexPath.item].url {
                let id = String(format: "%03d", Int(url.split(separator: "/").last!)!)
                if let imageUrl = URL(string: "https://assets.pokemon.com/assets/cms2/img/pokedex/full/\(id).png") {
                    cell.imageView.kf.setImage(with: imageUrl)
                }
            }
            if let name = self.speciesEvolutionArray[indexPath.item].name {
                cell.nameLabel.text = name
            }
            cell.nameLabel.backgroundColor = self.pokemonMainColor
            
            cell.nameLabel.layer.borderColor = UIColor.darkGray.cgColor
            cell.nameLabel.layer.borderWidth = 1
            cell.nameLabel.layer.cornerRadius = self.view.bounds.width*3/100
            
            return cell
        } else if collectionView.tag == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier:  "abilityCell", for: indexPath as IndexPath) as! AbilitiesCollectionViewCell
            cell.abilityButton.setTitle(self.pokemonDetail?.abilities?[indexPath.item].ability?.name, for: .normal)
            cell.abilityButton.tag = indexPath.item
            cell.backgroundColor = .clear
            cell.layer.borderColor = UIColor.darkGray.cgColor
            cell.layer.borderWidth = 1
            cell.layer.cornerRadius = self.view.bounds.width*4/100
            return cell
        }
        return UICollectionViewCell()
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  50
        if collectionView.tag == 0 {
            return CGSize(width: self.view.bounds.width*20/100, height: self.view.bounds.height*5/100)
        } else if collectionView.tag == 1 {
            let collectionViewSize = collectionView.frame.size.width - padding
            return CGSize(width: collectionViewSize/2, height: collectionViewSize/2)
        } else if collectionView.tag == 2 {
            return CGSize(width: self.view.bounds.width*30/100, height: self.view.bounds.height*4/100)
        }
        return CGSize(width: 0, height: 0)
    }
    
}
