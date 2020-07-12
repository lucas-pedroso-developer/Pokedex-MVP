import Foundation
import UIKit
import Presentation
import Domain
import Kingfisher

/*class TypeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var typeButton: UIButton!
}

class AbilitiesCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var abilityButton: UIButton!
}

class EvolutionCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
}*/

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
        self.setCornerRadius()
        self.segment.setTitleTextAttributes( [NSAttributedString.Key.foregroundColor: UIColor.black], for: .selected)
        self.configureBackGesture()
        self.getPokemonDetail()
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



