import Foundation

public struct Abilities : Model {
    let ability : Ability?
    let is_hidden : Bool?
    let slot : Int?
    
    public init(ability : Ability?, is_hidden : Bool?, slot : Int?) {
        self.ability = ability
        self.is_hidden = is_hidden
        self.slot = slot
    }

}
