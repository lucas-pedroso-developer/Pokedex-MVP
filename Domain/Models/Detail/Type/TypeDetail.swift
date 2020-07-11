import Foundation

public struct TypeDetail : Model {
    let pokemon : [TypePokemon]?
        
    public init(pokemon: [TypePokemon]?) throws {
        self.pokemon = pokemon
    }

}
