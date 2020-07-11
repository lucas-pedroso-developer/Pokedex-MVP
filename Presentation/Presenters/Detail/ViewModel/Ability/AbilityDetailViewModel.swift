import Foundation
import Domain

public struct AbilitiesDetailViewModel : Model {
    public let flavor_text_entries : [Ability_Flavor_text_EntriesViewModel]?
    
    public init(flavor_text_entries : [Ability_Flavor_text_EntriesViewModel]?) {
        self.flavor_text_entries = flavor_text_entries
    }

}
