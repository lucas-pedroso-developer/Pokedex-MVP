import Foundation
import Domain

public struct TypePokemonViewModel : Model {
    public let pokemon : PokemonViewModel?
    
    public init(pokemon : PokemonViewModel?) {
        self.pokemon = pokemon
    }

}
