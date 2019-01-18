//
// Created by jetbrains on 2019-01-18.
// Copyright (c) 2019 JetBrains. All rights reserved.
//

import Foundation
import UIKit

class ConferenceCell: UITableViewCell {
    override init(style: CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
