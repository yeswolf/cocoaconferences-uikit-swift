//
// Created by jetbrains on 2019-01-18.
// Copyright (c) 2019 JetBrains. All rights reserved.
//

import Foundation
import Yaml

class Cfp: Hashable, CustomStringConvertible {
    init(link: String, deadline: Date) {
        self.link = link
        self.deadline = deadline
    }

    let link: String //https://goo.gl/forms/eoX2WfG1LRoZPxxo1
    let deadline: Date? //2019-02-28

    init(yaml: Yaml) {
        self.link = yaml["link"].string!
        self.deadline = yaml["deadline"] != Yaml.null ? dateFormat.date(from: yaml["deadline"].string!) : nil
    }

    var hashValue: Int {
        var result = link.hashValue
        result = result * 31 + deadline.hashValue
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

    var description: String {
        return "Cfp(link: \(link), deadline: \(deadline))"
    }
}
