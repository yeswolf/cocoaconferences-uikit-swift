//
// Created by jetbrains on 2019-01-18.
// Copyright (c) 2019 JetBrains. All rights reserved.
//

import Foundation
import UIKit

class ConferenceViewController: UIViewController {
    var conference: Conference?

    @IBOutlet weak var linkLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var cfpDateLabel: UILabel!
    @IBOutlet weak var cfpLinkLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = conference?.name
        self.linkLabel.text = "🔗 \((conference?.link)!)"

        self.dateLabel.text = "🗓 \(friendlyDateFormat.string(from: (conference?.start)!))"
        if let end = conference?.end {
            self.dateLabel.text = "\(self.dateLabel.text!) - " + friendlyDateFormat.string(from: end)
        }

        self.locationLabel.text = conference?.location

        if let cfp = conference?.cfp {
            if let deadline = cfp.deadline {
                self.cfpDateLabel.text = "🖊🗓 \(friendlyDateFormat.string(from: deadline))"
            }else {
                cfpDateLabel.isHidden = true
            }
            self.cfpLinkLabel.text = "🖊🔗 \(cfp.link)"
        }else {
            cfpLinkLabel.isHidden = true
            cfpDateLabel.isHidden = true
        }

        for item in self.view.subviews {
            item.sizeToFit()
        }
    }
}
