import Foundation
import Domain

public struct Ability_Flavor_text_EntriesViewModel : Model {
    public let flavor_text : String?
    public let language : LanguageViewModel?
    public let version_group : Version_groupViewModel?

    public init(flavor_text : String?, language : LanguageViewModel?, version_group : Version_groupViewModel?) {
        self.flavor_text = flavor_text
        self.language = language
        self.version_group = version_group
    }

}
