//
// Created by jetbrains on 2019-01-18.
// Copyright (c) 2019 JetBrains. All rights reserved.
//

import Foundation
import Yams

class Cfp: Codable, Hashable {
    var link: String //https://goo.gl/forms/eoX2WfG1LRoZPxxo1
    var deadline: Date? //2019-02-28

    init() {
        link = ""
        deadline = nil
    }
    var description: String {
        return "Cfp(link: \(link), deadline: \(deadline))"
    }
    var hashValue: Int {
        var result = link.hashValue
        result = result * 31 + (deadline?.hashValue ?? 0)
        return result
    }

    static func ==(lhs: Cfp, rhs: Cfp) -> Bool {
        if lhs === rhs {
            return true
        }
        if type(of: lhs) != type(of: rhs) {
            return false
        }
        if lhs.link != rhs.link {
            return false
        }
        if lhs.deadline != rhs.deadline {
            return false
        }
        return true
    }
}
