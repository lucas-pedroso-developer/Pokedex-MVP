import Foundation
import Domain

public struct SpritesViewModel : Model {
    public let back_default : String?
    public let back_female : String?
    public let back_shiny : String?
    public let back_shiny_female : String?
    public let front_default : String?
    public let front_female : String?
    public let front_shiny : String?
    public let front_shiny_female : String?

    public init(back_default : String?, back_female : String?, back_shiny : String?, back_shiny_female : String?,
              front_default : String?, front_female : String?, front_shiny : String?, front_shiny_female : String?) {
        self.back_default = back_default
        self.back_female = back_female
        self.back_shiny = back_shiny
        self.back_shiny_female = back_shiny_female
        self.front_default = front_default
        self.front_female = front_female
        self.front_shiny = front_shiny
        self.front_shiny_female = front_shiny_female
    }

}
