//
// Created by jetbrains on 2019-01-18.
// Copyright (c) 2019 JetBrains. All rights reserved.
//

import Foundation
import Yams
import XCTest
import Alamofire
import Quick
import Nimble
@testable import CocoaConferences

class NetworkTests: QuickSpec {
    override func spec() {
        super.spec()
        describe("API") {
            it("should load conference list") {
                waitUntil(timeout: 5) { done in
                    Alamofire.request(confURL).response { response in
                        if let dt = response.data, let data = String(data: dt, encoding: .utf8) {
                            expect(data).toNot(beEmpty())

                            let decoder = YAMLDecoder()
                            let yaml = try! decoder.decode([Conference].self, from: data)

                            expect(yaml.count).to(beGreaterThan(0))
                            let conference = yaml[0]

                            expect(conference.name).toNot(beEmpty())
                            done()
                        }
                    }
                }
            }
            it("should load conference without CFP") {
                let decoder = YAMLDecoder()
                let yaml = try! decoder.decode([Conference].self, from:
                """
                - name: mDevCamp
                  link: https://mdevcamp.eu/
                  start: 2019-05-30
                  end: 2019-05-31
                  location: 🇨🇿 Prague, Czech Republic
                  cocoa-only: false
                  cfp:
                    link: https://goo.gl/forms/eoX2WfG1LRoZPxxo1
                    deadline: 2019-02-28
                """
                )
                let conference: Conference = yaml[0]
                expect(conference.name).to(equal("mDevCamp"))
                expect(conference.start).to(equal(dateFormat.date(from: "2019-05-30")))
                expect(conference.end).to(equal(dateFormat.date(from: "2019-05-31")))
                expect(conference.cocoaOnly).to(equal(false))
                expect(conference.location).to(equal("🇨🇿 Prague, Czech Republic"))

                let cfp = Cfp()
                cfp.link = "https://goo.gl/forms/eoX2WfG1LRoZPxxo1"
                cfp.deadline = dateFormat.date(from: "2019-02-28")

                expect(conference.cfp!.link).to(equal(cfp.link))
                expect(conference.cfp!.deadline).to(equal(cfp.deadline))
            }
            it("should load conference with CFP") {
                let decoder = YAMLDecoder()
                let yaml = try! decoder.decode([Conference].self, from:
                """
                - name: mDevCamp
                  link: https://mdevcamp.eu/
                  start: 2019-05-30
                  end: 2019-05-31
                  location: 🇨🇿 Prague, Czech Republic
                  cocoa-only: false
                """
                )
                let conference = yaml[0]
                expect(conference.name).to(equal("mDevCamp"))
                expect(conference.start).to(equal(dateFormat.date(from: "2019-05-30")))
                expect(conference.end).to(equal(dateFormat.date(from: "2019-05-31")))
                expect(conference.cocoaOnly).to(equal(false))
                expect(conference.location).to(equal("🇨🇿 Prague, Czech Republic"))
                expect(conference.cfp).to(beNil())
            }
        }
    }
}
