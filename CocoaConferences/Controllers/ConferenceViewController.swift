//
// Created by jetbrains on 2019-01-18.
// Copyright (c) 2019 JetBrains. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class ConferenceViewController: UIViewController {
    var conference: Conference?

    lazy var boxView: UIView = {
        let view = UIView()
        return view
    }()

    lazy var linkLabel: UILabel = UILabel()
    lazy var dateLabel: UILabel = UILabel()
    lazy var locationLabel: UILabel = UILabel()
    lazy var cfpDateLabel: UILabel = UILabel()
    lazy var cfpLinkLabel: UILabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = conference?.name
        self.view.backgroundColor = .white
        let margin: CGFloat = 10
        let labelHeight: CGFloat = 40

        self.view.addSubview(boxView)
        boxView.snp.makeConstraints { maker in
            maker.width.equalTo(self.view.frame.size.width - 2 * margin)
            maker.height.equalTo(self.view.frame.size.height - 2 * margin)
            maker.left.equalTo(margin)
            maker.top.equalTo(margin)
        }

        self.linkLabel.text = "🔗 \((conference?.link)!)"
        boxView.addSubview(linkLabel)
        linkLabel.snp.makeConstraints { maker in
            maker.width.equalToSuperview()
            maker.height.equalTo(labelHeight)
            maker.left.topMargin.equalTo(0)
        }

        self.dateLabel.text = "🗓 \(friendlyDateFormat.string(from: (conference?.start)!))"
        if let end = conference?.end {
            self.dateLabel.text = "\(self.dateLabel.text!) - " + friendlyDateFormat.string(from: end)
        }
        boxView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { maker in
            maker.width.equalToSuperview()
            maker.height.equalTo(labelHeight)
            maker.left.equalTo(0)
            maker.topMargin.equalTo(linkLabel.snp.bottom)
        }

        self.locationLabel.text = conference?.location
        boxView.addSubview(locationLabel)
        locationLabel.snp.makeConstraints { maker in
            maker.width.equalToSuperview()
            maker.height.equalTo(labelHeight)
            maker.left.equalTo(0)
            maker.topMargin.equalTo(dateLabel.snp.bottom)
        }
        if let cfp = conference?.cfp {
            self.cfpLinkLabel.text = "🖊🔗 \(cfp.link)"
            if let deadline = cfp.deadline {
                self.cfpDateLabel.text = "🖊🗓 \(friendlyDateFormat.string(from: deadline))"
            } else {
                cfpDateLabel.isHidden = true
            }
            boxView.addSubview(cfpLinkLabel)
            cfpLinkLabel.snp.makeConstraints { maker in
                maker.width.equalToSuperview()
                maker.height.equalTo(labelHeight)
                maker.left.equalTo(0)
                maker.topMargin.equalTo(locationLabel.snp.bottom)
            }
            boxView.addSubview(cfpDateLabel)
            cfpDateLabel.snp.makeConstraints { maker in
                maker.width.equalToSuperview()
                maker.height.equalTo(labelHeight)
                maker.left.equalTo(0)
                maker.topMargin.equalTo(cfpLinkLabel.snp.bottom)
            }

        } else {
            cfpLinkLabel.isHidden = true
            cfpDateLabel.isHidden = true
        }
    }
}
