import Foundation
import Domain

public struct AbilitiesViewModel : Model {
    public let ability : AbilityViewModel?
    public let is_hidden : Bool?
    public let slot : Int?
    
    public init(ability : AbilityViewModel?, is_hidden : Bool?, slot : Int?) {
        self.ability = ability
        self.is_hidden = is_hidden
        self.slot = slot
    }

}
