//
//  offerRequestTests.swift
//  sponsorPay
//
//  Created by Damien Martin on 04/10/2014.
//  Copyright (c) 2014 Damien Martin. All rights reserved.
//

import UIKit
import XCTest

class offerRequestTests: XCTestCase {
	
	var request: OfferRequest?
	
    override func setUp() {
        super.setUp()
		request = OfferRequest();
		
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testDefaultOrderedParams() {
		let paramsOrdered: NSArray = self.request!.orderedParams()
		
		XCTAssertFalse( (paramsOrdered.count == 0), "No params")
		
		var lastKey: String?
		paramsOrdered.enumerateObjectsUsingBlock { (param: AnyObject!, index, stop) -> Void in
			if let key = param.allKeys.first as? String {
				if let value = param.objectForKey(key) as? String {
					if lastKey != nil {
						XCTAssert( (key > lastKey), " Not ordered \(key) > \(lastKey!)")
					}
					lastKey = key;
				}
				else {
					XCTAssert(false, "no value for key on dictionnary param")
				}
				
			}
			else {
				XCTAssert(false, "no key on dictionnary param")
			}
		}
	}
	
	func testDefaultRequestParamsValue() {
		let requestParamsValue = self.request!.requestParamsValue();
	
		XCTAssertFalse(requestParamsValue.isEmpty, "requestParamsValue is Empty")
		
		let defaultValue = "appid=2070&apple_idfa=TEST&format=json&ip=109.235.143.113&locale=DE&offer_types=112&uid=spiderman"
		XCTAssert( (requestParamsValue == defaultValue), "requestParamsValue is Empty")
		
		
		
	}

}
