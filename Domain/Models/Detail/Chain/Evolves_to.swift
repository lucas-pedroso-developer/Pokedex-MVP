import Foundation

public struct Evolves_to : Model {
    let evolves_to : [Evolves_to]?
    let species : Species?

    public init(evolves_to : [Evolves_to]?, species : Species?) {
        self.evolves_to = evolves_to
        self.species = species
    }

}
