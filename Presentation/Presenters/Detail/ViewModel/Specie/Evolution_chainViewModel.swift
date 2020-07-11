import Foundation
import Domain

public struct Evolution_chainViewModel : Model {
    public let url : String?

    public init(url : String?) {
        self.url = url
    }

}
