//
// Created by jetbrains on 2019-01-18.
// Copyright (c) 2019 JetBrains. All rights reserved.
//

import Foundation
import Yaml

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
class Conference: CustomStringConvertible {
    var name = ""
    var start: Date?
    var end: Date?
    var location: String
    var cocoaOnly = false
    var cfp: Cfp?
    var link: String?

    init(yaml: Yaml) {
        self.name = yaml["name"].string!

        self.start = yaml["start"] != Yaml.null ? dateFormat.date(from: yaml["start"].string!) : nil
        self.end = yaml["end"] != Yaml.null ? dateFormat.date(from: yaml["end"].string!) : nil
        self.location = yaml["location"].string!
        self.cocoaOnly = yaml["cocoa-only"].bool!
        if (yaml["cfp"] != Yaml.null) {
            self.cfp = Cfp(yaml: yaml["cfp"])
        }
        self.link = yaml["link"].string
    }

    var description: String {
        return "Conference(name: \(name), start: \(start), end: \(end), location: \(location), cocoaOnly: \(cocoaOnly), cfp: \(cfp), link: \(link))"
    }
}
