import Foundation
import Yams

class Conference: Codable {
    var name = ""
    var location: String
    var cocoaOnly = false
    var start: Date?
    var end: Date?
    var cfp: Cfp?
    var link: String?

    private enum CodingKeys: String, CodingKey {
        case cfp
        case cocoaOnly = "cocoa-only"
        case end
        case link
        case location
        case name
        case start

    }

}
