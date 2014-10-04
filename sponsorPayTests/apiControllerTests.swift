//
//  apiControllerTests.swift
//  sponsorPay
//
//  Created by Damien Martin on 04/10/2014.
//  Copyright (c) 2014 Damien Martin. All rights reserved.
//

import UIKit
import XCTest

class apiControllerTests: XCTestCase {

	var apiController: SponsorPayApiController?
    override func setUp() {
        super.setUp()
		apiController = SponsorPayApiController();
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

	func testApiUriGenerator() {
		
		let uriForOffersEndPoint = apiController?.uriForEndPoint(SponsorPayEndPoint.Offers)
		let correctUriForOffersEndPoint = "http://api.sponsorpay.com/feed/v1/offers.json"
		XCTAssert(uriForOffersEndPoint == correctUriForOffersEndPoint, "Uri for Offers is wrong : \(uriForOffersEndPoint) != \(correctUriForOffersEndPoint)" )
		
		
	}

}
