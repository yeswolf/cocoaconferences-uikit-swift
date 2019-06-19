//
// Created by jetbrains on 2019-01-18.
// Copyright (c) 2019 JetBrains. All rights reserved.
//

import Foundation

let confURL = "https://raw.githubusercontent.com/Lascorbe/CocoaConferences/master/_data/conferences.yml"
var dateFormat: DateFormatter = {
    let format = DateFormatter()
    format.dateFormat = "yyyy-MM-dd"
    format.locale = Locale(identifier: "en_US_POSIX")
    return format
}()

var friendlyDateFormat: DateFormatter = {
    let format = DateFormatter()
    format.dateFormat = "MMMM dd, yyyy"
    format.locale = Locale(identifier: "en_US_POSIX")
    return format
}()

func zeroDateComponents(from date: String) -> Date {
    let date = dateFormat.date(from: date)
    var comps = Calendar.current.dateComponents([.year, .month, .day], from: date!)
    comps.timeZone = TimeZone(secondsFromGMT: 0)
    return Calendar.current.date(from: comps)!
}
