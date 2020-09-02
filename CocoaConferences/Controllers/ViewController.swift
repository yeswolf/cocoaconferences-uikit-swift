//
//  ViewController.swift
//  CocoaConferences
//
//  Created by jetbrains on 2019-01-18.
//  Copyright © 2019 JetBrains. All rights reserved.
//

import UIKit
import Alamofire
import Yams

class ViewController: UIViewController {

    @IBOutlet weak var loader: UIActivityIndicatorView!
    var conferences: Array<Conference> = Array()

    let tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.register(ConferenceCell.self, forCellReuseIdentifier: "id")
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        loadConferences()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }

    private func loadConferences() {
        AF.request(confURL).response { response in
            if let dt = response.data, let data = String(data: dt, encoding: .utf8) {
                let decoder = YAMLDecoder()
                self.conferences = try! decoder.decode([Conference].self, from: data)
            }
            self.view.addSubview(self.tableView)
            self.loader.stopAnimating()
            self.tableView.reloadData()
        }
    }
}

extension ViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = ConferenceViewController()
        let conference = conferences[indexPath.row]
        controller.conference = conference
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

extension ViewController: UITableViewDataSource {

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return conferences.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "id", for: indexPath)
        let conference = conferences[indexPath.row]
        cell.textLabel?.text = conference.name
        cell.detailTextLabel?.text = conference.location
        return cell
    }
}
