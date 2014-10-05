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

		request!.fixedTimestamp = "1234567890"
		
		let uriForOffersEndPoint = apiController?.uriForEndPoint(SponsorPayEndPoint.Offers)
		let correctUriForOffersEndPoint = "http://api.sponsorpay.com/feed/v1/offers.json"
		XCTAssert(uriForOffersEndPoint == correctUriForOffersEndPoint, "Uri for Offers is wrong : \(uriForOffersEndPoint) != \(correctUriForOffersEndPoint)" )
		
		let uriForOffersRequest = apiController!.uriForRequest(self.request!)
		let correctUriForOffersRequest: String = "http://api.sponsorpay.com/feed/v1/offers.json?appid=2070&device_id=35031BBD-6D94-4409-A3FB-96BF732899F3&format=json&ip=109.235.143.113&locale=DE&offer_types=112&timestamp=1234567890&uid=spiderman&hashkey=28d3724830fda9bc5bd41aebc1f3ed25e98eea26"
		XCTAssert(uriForOffersRequest == correctUriForOffersRequest, "Uri for Offers is wrong : \(uriForOffersRequest) != \(correctUriForOffersRequest)" )
		
	}

	func testCorrectAsynchronousCall() {
		let expectation = expectationWithDescription("Sponsor Pay header hash")
		
		self.apiController?.getOffers(self.request!, completionHandler: { (results, error) -> Void in
			
			expectation.fulfill()
			XCTAssertNotNil(results, "data should not be nil")
			XCTAssertNil(error, "error should be nil")
			
		})

		waitForExpectationsWithTimeout(20, handler: { error in
		})
		
	}
	
	func testWrongAsynchronousCall() {
		let expectation = expectationWithDescription("Sponsor Pay header hash")
		
		request!.fixedTimestamp = "123456"
		
		self.apiController?.getOffers(self.request!, completionHandler: { (results, error) -> Void in
			
			expectation.fulfill()
			XCTAssertNil(results, "data should be nil")
			XCTAssertNotNil(error, "error should not be nil")
			
		})
		
		
		waitForExpectationsWithTimeout(20, handler: { error in
		})
	}
	
	func testWrongQueryAsynchronousCall() {
		let expectation = expectationWithDescription("Sponsor Pay header hash")
		
		request!.fixedTimestamp = "123456"
		request!.apiKey = ""
		
		self.apiController?.getOffers(self.request!, completionHandler: { (results, error) -> Void in
			
			expectation.fulfill()
			
			XCTAssertNil(results, "data should be nil")
			XCTAssertNotNil(error, "error should not be nil")
			
			XCTAssertEqual(error!, "Incorrect query : Missing params", "Error message isn't correct")
		})
		
		
		waitForExpectationsWithTimeout(20, handler: { error in
		})
	}


}
