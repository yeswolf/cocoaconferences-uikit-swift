//
// Created by jetbrains on 2019-01-18.
// Copyright (c) 2019 JetBrains. All rights reserved.
//

import Foundation
import Yams

/*
name: mDevCamp
  link: https://mdevcamp.eu/
  start: 2019-05-30
  end: 2019-05-31
  location: 🇨🇿 Prague, Czech Republic
  cocoa-only: false
  cfp:
    link: https://goo.gl/forms/eoX2WfG1LRoZPxxo1
    deadline: 2019-02-28
*/
class Conference: Codable {
    var name = ""
    var start: Date?
    var end: Date?
    var location: String
    var cocoaOnly = false
    var cfp: Cfp?
    var link: String?

    private enum CodingKeys: String, CodingKey {
        case name
        case start
        case end
        case location
        case cocoaOnly = "cocoa-only"
        case cfp
        case link
    }

}
