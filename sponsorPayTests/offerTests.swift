//
//  offerTests.swift
//  sponsorPay
//
//  Created by Damien Martin on 05/10/2014.
//  Copyright (c) 2014 Damien Martin. All rights reserved.
//

import UIKit
import XCTest

class offerTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

	func parsingTest() {
		
		let dictionaryOk = ["title":"title1","teaser":"teaser1","payout":123,"thumbnail":["lowres":"lowres1","hires":"hires1"]]
		let offer = Offer(dictionary: dictionaryOk);
		
		XCTAssertNotNil( offer.title, "Title can't be nil")
		XCTAssertNotNil( offer.teaser, "Teaser can't be nil")
		XCTAssertNotNil( offer.payout, "Payout can't be nil")
		XCTAssertNotNil( offer.thumbnail, "thumbnail can't be nil")
		XCTAssertNotNil( offer.thumbnail!.hires, "Hires can't be nil")
		XCTAssertNotNil( offer.thumbnail!.lowres, "Lowres can't be nil")
		
		XCTAssertEqual( offer.title!, "title1", "Title not well setted : \(offer.title) != title1")
		XCTAssertEqual( offer.teaser!, "teaser1", "Teaser not well setted : \(offer.teaser) != teaser1")
		XCTAssertEqual( offer.payout!, 123, "Payout not well setted : \(offer.payout) != payout1")
		XCTAssertEqual( offer.thumbnail!.hires!, "hires1", "Hires not well setted : \(offer.thumbnail!.hires) != hires1")
		XCTAssertEqual( offer.thumbnail!.lowres!, "lowres1", "Lowres not well setted : \(offer.thumbnail!.lowres) != lowres1")
		
	}

}
