import Foundation
import Domain

public struct Evolves_toViewModel : Model {
    public let evolves_to : [Evolves_toViewModel]?
    public let species : SpeciesViewModel?

    public init(evolves_to : [Evolves_toViewModel]?, species : SpeciesViewModel?) {
        self.evolves_to = evolves_to
        self.species = species
    }

}
