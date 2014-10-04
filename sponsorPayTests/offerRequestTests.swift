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
		let requestParamsValue = self.request!.requestParamsValue(apiKey: false, hashValue: false)
	
		XCTAssertFalse(requestParamsValue.isEmpty, "requestParamsValue is Empty")
		println("\(requestParamsValue)")
		
		let defaultValue = "appid=2070&format=json&ip=109.235.143.113&locale=DE&offer_types=112&uid=spiderman"
		XCTAssert( (requestParamsValue == defaultValue), "requestParamsValue is wrong \(requestParamsValue) != \(defaultValue)")
		
	}
	
	/// Test the method to get params Value : 
	/// - with and without APIKey params
	/// - with and without HashKey params
	func testRequestParamsValue() {
		let requestParamsValue = self.request!.requestParamsValue(apiKey: false, hashValue: false)
		
		// Test with no APIKey and no HashKey
		let defaultValue = "appid=2070&format=json&ip=109.235.143.113&locale=DE&offer_types=112&uid=spiderman"
		XCTAssert( (requestParamsValue == defaultValue), "requestParamsValue is wrong \(requestParamsValue) != \(defaultValue)")
		
		// Test with no APIKey and HashKey
		let requestParamsValueWithHashKey = self.request!.requestParamsValue(apiKey: false, hashValue: true)
		let haskKey = self.request!.authenticationHash();
		let defaultValueWithHashKey = "\(defaultValue)&hashkey=\(haskKey)"
		XCTAssert( (requestParamsValueWithHashKey == defaultValueWithHashKey), "requestParamsValue is wrong \(requestParamsValueWithHashKey) != \(defaultValueWithHashKey)")
		
		// Test with APIKey and no HashKey
		let testApiKey = "123456789"
		self.request!.setApiKey(apiKey: testApiKey)
		let requestParamsValueWithApiKey = self.request!.requestParamsValue(apiKey: true, hashValue: false)
		let defaultValueWithApiKey = "\(defaultValue)&\(testApiKey)"
		XCTAssert( (requestParamsValueWithApiKey == defaultValueWithApiKey), "requestParamsValue is wrong \(requestParamsValueWithApiKey) != \(defaultValueWithApiKey)")
		
	}
	
	/// Test Hash authentication
	func testAuthenticationHash() {
		// Doc Example hash
		request!.appid = "157";
		request!.deviceId = "2b6f0cc904d137be2e1730235f5664094b831186"
		request!.ip = "212.45.111.17"
		request!.locale = "de"
		request!.page = "2"
		request!.ps_time = "1312211903"
		request!.pub0 = "campaign2"
		request!.timestamp = "1312553361"
		request!.uid = "player1"
		request!.offerTypes = nil;
		request!.format = nil;
		request!.appleIdfa = nil;
			
		request!.setApiKey(apiKey: "e95a21621a1865bcbae3bee89c4d4f84")
		
		let paramsValue = request!.requestParamsValue(apiKey: false, hashValue: false)
		let normalParamsValue = "appid=157&device_id=2b6f0cc904d137be2e1730235f5664094b831186&ip=212.45.111.17&locale=de&page=2&ps_time=1312211903&pub0=campaign2&timestamp=1312553361&uid=player1"
		
		XCTAssert( (paramsValue == normalParamsValue), "paramsValue not good : \(paramsValue) != \(normalParamsValue)");
		
		let hash = self.request!.authenticationHash();
		XCTAssertFalse( hash.isEmpty, "Hash is empty");
		
		let testHash = "7a2b1604c03d46eec1ecd4a686787b75dd693c4d"
		XCTAssert( (hash == testHash), "Wrong hash : \(hash) != \(testHash)" );
		
		// Change one params and see if hash is different 
		self.request!.page = "3"
		let newHash = self.request!.authenticationHash();
		XCTAssert( (hash != newHash), "Hash don't change : \(hash) != \(newHash)" );
	}

}
