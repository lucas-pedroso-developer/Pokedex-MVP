import Foundation
import Domain

public struct DetailViewModel : Model {
    public let id : Int?
    public let name : String?
    public let height : Int?
    public let weight : Int?
    public let stats : [StatsViewModel]?
    public let abilities : [AbilitiesViewModel]?
    public let types : [TypesViewModel]?
    public let species : SpeciesViewModel?
    public let sprites : SpritesViewModel?
        
    public init(id : Int?, name : String?, height : Int?, weight : Int?, stats : [StatsViewModel]?, abilities : [AbilitiesViewModel]?, types : [TypesViewModel]?, species : SpeciesViewModel?, sprites : SpritesViewModel?) {
        self.id = id
        self.name = name
        self.height = height
        self.weight = weight
        self.stats = stats
        self.abilities = abilities
        self.types = types
        self.species = species
        self.sprites = sprites
                
    }

}
