import Foundation
import Domain

public struct ChainViewModel: Model {
    public let evolves_to : [Evolves_toViewModel]?
    public let species : SpeciesViewModel?

    public init(evolves_to : [Evolves_toViewModel]?, species : SpeciesViewModel?) {
        self.evolves_to = evolves_to
        self.species = species
    }

}
