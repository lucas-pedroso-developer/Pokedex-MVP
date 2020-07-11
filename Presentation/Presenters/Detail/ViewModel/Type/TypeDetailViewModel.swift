import Foundation
import Domain

public struct TypeDetailViewModel : Model {
    public let pokemon : [TypePokemonViewModel]?
        
    public init(pokemon: [TypePokemonViewModel]?) throws {
        self.pokemon = pokemon
    }

}
