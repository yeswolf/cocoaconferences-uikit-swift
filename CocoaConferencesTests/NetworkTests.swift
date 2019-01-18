//
// Created by jetbrains on 2019-01-18.
// Copyright (c) 2019 JetBrains. All rights reserved.
//

import Foundation
import Yaml
import XCTest
import Quick
import Nimble
import Alamofire

@testable import CocoaConferences

class NetworkTests: QuickSpec {
    override func spec() {
        super.spec()
        describe("API") {
            it("should load conferences list") {
                waitUntil(timeout: 5) { done in
                    Alamofire.request(confURL).response { response in
                        if let dt = response.data, let data = String(data: dt, encoding: .utf8) {
                            expect(data).toNot(beEmpty())
                            let yaml = try! Yaml.load(data)
                            expect(yaml.count).to(beGreaterThan(0))
                            let conference = Conference(yaml: yaml[0])
                            expect(conference.name).toNot(beEmpty())
                            done()
                        }
                    }
                }
            }
            it("should load conference with CFP") {
                waitUntil(timeout: 5) { done in
                    Alamofire.request(confURL).response { response in
                        if let dt = response.data, let data = String(data: dt, encoding: .utf8) {
                            let yaml = try! Yaml.load(data)
                            let conference = Conference(yaml: yaml[0])
                            expect(conference.name).to(equal("mDevCamp"))
                            expect(conference.start).to(equal(dateFormat.date(from: "2019-05-30")))
                            expect(conference.end).to(equal(dateFormat.date(from: "2019-05-31")))
                            expect(conference.cocoaOnly).to(equal(false))
                            expect(conference.location).to(equal("🇨🇿 Prague, Czech Republic"))
                            let cfp = Cfp(link: "https://goo.gl/forms/eoX2WfG1LRoZPxxo1", deadline: dateFormat.date(from: "2019-02-28")!)
                            expect(conference.cfp!).to(equal(cfp))
                            done()
                        }
                    }
                }
            }
            it("should load all conferences") {
                waitUntil(timeout: 5) { done in
                    Alamofire.request(confURL).response { response in
                        if let dt = response.data, let data = String(data: dt, encoding: .utf8) {
                            let yaml = try! Yaml.load(data)

                            for conf in yaml.array! {
                                let conference = Conference(yaml: conf)
                                expect(conference != nil)
                            }
                            done()
                        }
                    }
                }

            }
        }
    }
}