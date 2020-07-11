import Foundation
import Domain

public struct Flavor_text_entriesViewModel : Model {
    public let flavor_text : String?
    public let language : LanguageViewModel?
    public let version : VersionViewModel?

    public init(flavor_text : String?, language : LanguageViewModel?, version : VersionViewModel?)  {
        self.flavor_text = flavor_text
        self.language = language
        self.version = version
    }

}
