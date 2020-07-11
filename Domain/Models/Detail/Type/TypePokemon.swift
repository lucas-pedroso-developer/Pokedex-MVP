import Foundation

public struct TypePokemon : Model {
    let pokemon : Pokemon?
    
    public init(pokemon : Pokemon?) {
        self.pokemon = pokemon
    }

}
