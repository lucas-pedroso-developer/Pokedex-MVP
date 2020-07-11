import Foundation
import UIKit
import Presentation
import Domain
import Kingfisher

class TypeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var typeButton: UIButton!
}

class AbilitiesCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var abilityButton: UIButton!
}

class EvolutionCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
}

public final class DetailViewController: UIViewController, Storyboarded {
    
    var id: Int = 0
    var pokemonDetail: DetailViewModel?
    var specie: SpecieDetailViewModel?
    var evolutionChain: EvolutionChainDetailViewModel?
    var ability: AbilitiesDetailViewModel?
    var type: TypeDetailViewModel?
    var types: [TypesViewModel]?
    var pokemonArray: [Int: String] = [:]
    var speciesEvolutionArray: [SpeciesViewModel] = []
    var pokemonMainColor: UIColor?
    var showingGif: Bool = false
    
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var navbar: UINavigationBar!
    @IBOutlet weak var pokemonIdLabel: UILabel!
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var hpLabel: UILabel!
    @IBOutlet weak var atackLabel: UILabel!
    @IBOutlet weak var defenseLabel: UILabel!
    @IBOutlet weak var specialAtackLabel: UILabel!
    @IBOutlet weak var specialDefenseLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var abilityLabel: UILabel!
        
    @IBOutlet weak var typeCollectionView: UICollectionView!
    @IBOutlet weak var evolutionCollectionView: UICollectionView!
    @IBOutlet weak var abilitiesCollectionView: UICollectionView!
    
        
    @IBOutlet weak var segment: UISegmentedControl!
    
    @IBOutlet weak var pokemonImageBackgroundView: UIView!
    @IBOutlet weak var pokemonImageBackgroundViewHeight: NSLayoutConstraint!
    @IBOutlet weak var pokemonImageBackgroundViewWidth: NSLayoutConstraint!
    
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    
    @IBOutlet weak var whiteBackgroundView: UIView!
    
    @IBOutlet weak var dataView: UIView!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var evolutionView: UIView!
    
    @IBOutlet weak var typeColorBackgroundView: UIView!
    
    @IBOutlet weak var backNavBarButton: UIBarButtonItem!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dataDescriptionLabel: UILabel!
      
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var modalView: UIView!
    @IBOutlet weak var abilityModalNameLabel: UILabel!
    @IBOutlet weak var abilityModalDescriptionTextView: UITextView!
    @IBOutlet weak var abilityModalCloseButton: UIButton!
    
    @IBOutlet weak var gifButton: UIBarButtonItem!
    
    @IBOutlet weak var hpProgress: UIProgressView!
    @IBOutlet weak var atackProgress: UIProgressView!
    @IBOutlet weak var defenseProgress: UIProgressView!
    @IBOutlet weak var specialAtackProgress: UIProgressView!
    @IBOutlet weak var specialDefenseProgress: UIProgressView!
    @IBOutlet weak var speedProgress: UIProgressView!
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var backgroundView: UIView!
    
    
    public var getDetail: ((_ url: String) -> Void?)?
    public var getSpecie: ((_ url: String) -> Void?)?
    public var getEvolution: ((_ url: String) -> Void?)?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardOnTap()
        self.setDelegates()
        self.setCornerRadius()
        
        self.segment.setTitleTextAttributes( [NSAttributedString.Key.foregroundColor: UIColor.black], for: .selected)
        self.configureBackGesture()
        self.getPokemonDetail()
    }
            
   func setDelegates() {
       typeCollectionView.delegate = self
       typeCollectionView.dataSource = self
       
       abilitiesCollectionView.delegate = self
       abilitiesCollectionView.dataSource = self
       
       evolutionCollectionView.delegate = self
       evolutionCollectionView.dataSource = self
   }
   
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func change(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            self.dataView.isHidden = false
            self.statusView.isHidden = true
            self.evolutionView.isHidden = true
        } else if sender.selectedSegmentIndex == 1 {
            self.dataView.isHidden = true
            self.statusView.isHidden = false
            self.evolutionView.isHidden = true
        } else if sender.selectedSegmentIndex == 2 {
            self.dataView.isHidden = true
            self.statusView.isHidden = true
            self.evolutionView.isHidden = false
        }
    }
    
    
    func setCornerRadius() {
       self.pokemonImageBackgroundView.layer.cornerRadius = self.view.bounds.height*12/100
       
       self.whiteBackgroundView.layer.cornerRadius = self.view.bounds.height*4/100
       self.whiteBackgroundView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
       
       self.abilityLabel.layer.cornerRadius = self.view.bounds.height*1/100
       self.dataDescriptionLabel.layer.cornerRadius = self.view.bounds.height*1/100
       
   }
    
    func configureBackGesture() {
        let slideDown = UISwipeGestureRecognizer(target: self, action: #selector(dismissView(gesture:)))
        slideDown.direction = .right
        view.addGestureRecognizer(slideDown)
    }
    
    @objc func dismissView(gesture: UISwipeGestureRecognizer) {
        UIView.animate(withDuration: 0.4) {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func getPokemonDetail() {
        getDetail?("https://pokeapi.co/api/v2/pokemon/\(self.id)")
    }
    
}
        
extension DetailViewController: LoadingView {
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

extension DetailViewController: AlertView {
    public func showMessage(viewModel: AlertViewModel) {
        let alert = UIAlertController(title: viewModel.title, message: viewModel.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true)
    }
}

extension DetailViewController: DetailView {
    public func presentList(viewModel: DetailViewModel?) {
        self.pokemonDetail = viewModel
        self.setPokemonImage()
        self.setPokemonData()
        self.setPokemonStatus()
        self.setPokemonAbilities()
        self.setPokemonTypes()
        if let specieUrl = self.pokemonDetail?.species?.url {
            getSpecie!(specieUrl)
        }
    }
    
    public func presentSpecie(viewModel: SpecieDetailViewModel?) {
        self.specie = viewModel
        if let flavor_text_entries = self.specie?.flavor_text_entries {
            for flavor in flavor_text_entries {
                if (flavor.language?.name?.elementsEqual("en"))! && ((flavor.language?.name?.elementsEqual("alpha-sapphire")) != nil) {
                    if let text = flavor.flavor_text {
                        self.dataDescriptionLabel.text = text.replacingOccurrences(of: "\n", with: " ")
                    }
                }
            }
        }
                            
        if let url = self.specie?.evolution_chain?.url {
            getEvolution?(url)
        }
    }
    
    public func presentEvolution(viewModel: EvolutionChainDetailViewModel?) {
        self.evolutionChain = viewModel
        if let evolves = self.evolutionChain?.chain?.evolves_to {
            self.speciesEvolutionArray.append((self.evolutionChain?.chain?.species)!)
            var evolvesToData = evolves
            var hasEvolution = true
                          
            while hasEvolution {
                if evolvesToData.isEmpty {
                    hasEvolution = false
                    break
                }
                if evolvesToData.count == 1 {
                    self.speciesEvolutionArray.append((evolvesToData[0].species)!)
                    evolvesToData = evolvesToData[0].evolves_to!
                } else {
                    for pokemon in evolvesToData {
                        self.speciesEvolutionArray.append(pokemon.species!)
                    }
                    evolvesToData = evolvesToData[0].evolves_to!
                }
            }
            self.evolutionCollectionView.reloadData()
        }
    }
    
    private func setPokemonImage() {
        if let url = URL(string: "https://assets.pokemon.com/assets/cms2/img/pokedex/full/\(String(format: "%03d", id)).png") {
            self.pokemonImageView.kf.setImage(with: url)
        }
    }
    
    private func setPokemonData() {
        if let name = self.pokemonDetail?.name {
            self.pokemonNameLabel.text = name
        }
        
        if let id = self.pokemonDetail?.id {
            self.pokemonIdLabel.text = "# \(String(format: "%03d", id))"
            
        }
        
        if let height = self.pokemonDetail?.height {
            self.heightLabel.text = "\(height)"
        }
        
        if let weight = self.pokemonDetail?.weight {
            self.weightLabel.text = "\(weight)"
        }
    }
            
    private func setPokemonStatus() {
        let stats = self.pokemonDetail?.stats
        for stat in stats! {
            let name = stat.stat?.name!
            
            if (name?.elementsEqual("hp"))! {
                if let base_stat = stat.base_stat {
                    self.hpLabel.text = "\(base_stat)"
                    self.hpProgress.setProgress(((self.hpLabel.text?.floatValue())!/500), animated: false)
                }
            } else if (name?.elementsEqual("defense"))! {
                if let base_stat = stat.base_stat {
                    self.atackLabel.text = "\(base_stat)"
                    self.atackProgress.setProgress(((self.atackLabel.text?.floatValue())!/500), animated: false)
                }
            } else if (name?.elementsEqual("attack"))! {
                if let base_stat = stat.base_stat {
                    self.defenseLabel.text = "\(base_stat)"
                    self.defenseProgress.setProgress(((self.defenseLabel.text?.floatValue())!/500), animated: false)
                }
            } else if (name?.elementsEqual("special-attack"))! {
                if let base_stat = stat.base_stat {
                    self.specialAtackLabel.text = "\(base_stat)"
                    self.specialAtackProgress.setProgress(((self.specialAtackLabel.text?.floatValue())!/500), animated: false)
                }
            } else if (name?.elementsEqual("special-defense"))! {
                if let base_stat = stat.base_stat {
                    self.specialDefenseLabel.text = "\(base_stat)"
                    self.specialDefenseProgress.setProgress(((self.specialDefenseLabel.text?.floatValue())!/500), animated: false)
                }
            } else if (name?.elementsEqual("speed"))! {
                if let base_stat = stat.base_stat {
                    self.speedLabel.text = "\(base_stat)"
                    self.speedProgress.setProgress(((self.speedLabel.text?.floatValue())!/500), animated: false)
                }
            } else {
                print("erro")
            }
        }
    }
    
    private func setPokemonAbilities() {
        self.abilitiesCollectionView.reloadData()
    }
    
    private func setPokemonTypes() {
        self.types = self.pokemonDetail?.types
        self.typeCollectionView.reloadData()
    }
}

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

