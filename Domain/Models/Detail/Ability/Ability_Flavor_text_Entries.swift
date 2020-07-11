import Foundation

public struct Ability_Flavor_text_Entries : Model {
    let flavor_text : String?
    let language : Language?
    let version_group : Version_group?

    public init(flavor_text : String?, language : Language?, version_group : Version_group?) {
        self.flavor_text = flavor_text
        self.language = language
        self.version_group = version_group
    }

}
