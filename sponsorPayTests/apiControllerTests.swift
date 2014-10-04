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
	var request: OfferRequest?
	
    override func setUp() {
        super.setUp()
		apiController = SponsorPayApiController();
		request = OfferRequest();
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

	func testApiUriGenerator() {
		
		let uriForOffersEndPoint = apiController?.uriForEndPoint(SponsorPayEndPoint.Offers)
		let correctUriForOffersEndPoint = "http://api.sponsorpay.com/feed/v1/offers.json"
		XCTAssert(uriForOffersEndPoint == correctUriForOffersEndPoint, "Uri for Offers is wrong : \(uriForOffersEndPoint) != \(correctUriForOffersEndPoint)" )
		
		let uriForOffersRequest = apiController?.uriForRequest(self.request!)
		let correctUriForOffersRequest: String = "http://api.sponsorpay.com/feed/v1/offers.json?appid=2070&format=json&ip=109.235.143.113&locale=DE&offer_types=112&uid=spiderman&hashkey=7a35485528d6ce8d41db82262afb3ed14d9eb054"
		XCTAssert(uriForOffersRequest == correctUriForOffersRequest, "Uri for Offers is wrong : \(uriForOffersRequest) != \(correctUriForOffersRequest)" )
		
	}

}
