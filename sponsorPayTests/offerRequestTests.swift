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
		request!.fixedTimestamp = "1312553361"
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
		
		let defaultValue = "appid=\(request!.appid!)&device_id=\(request!.deviceId)&format=\(request!.format!)&ip=\(request!.ip!)&locale=\(request!.locale!)&offer_types=\(request!.offerTypes!)&timestamp=\(request!.timestamp)&uid=\(request!.uid!)"
		XCTAssert( (requestParamsValue == defaultValue), "requestParamsValue is wrong \(requestParamsValue) != \(defaultValue)")
		
	}
	
	/// Test the method to get params Value : 
	/// - with and without APIKey params
	/// - with and without HashKey params
	func testRequestParamsValue() {
		let requestParamsValue = self.request!.requestParamsValue(apiKey: false, hashValue: false)
		
		// Test with no APIKey and no HashKey
		let defaultValue = "appid=\(request!.appid!)&device_id=\(request!.deviceId)&format=\(request!.format!)&ip=\(request!.ip!)&locale=\(request!.locale!)&offer_types=\(request!.offerTypes!)&timestamp=\(request!.timestamp)&uid=\(request!.uid!)"
		
		XCTAssert( (requestParamsValue == defaultValue), "requestParamsValue is wrong \(requestParamsValue) != \(defaultValue)")
		
		// Test with no APIKey and HashKey
		let requestParamsValueWithHashKey = self.request!.requestParamsValue(apiKey: false, hashValue: true)
		let haskKey = self.request!.authenticationHash();
		let defaultValueWithHashKey = "\(defaultValue)&hashkey=\(haskKey)"
		XCTAssert( (requestParamsValueWithHashKey == defaultValueWithHashKey), "requestParamsValue is wrong \(requestParamsValueWithHashKey) != \(defaultValueWithHashKey)")
		
		// Test with APIKey and no HashKey
		let testApiKey = "123456789"
		self.request!.apiKey = testApiKey
		let requestParamsValueWithApiKey = self.request!.requestParamsValue(apiKey: true, hashValue: false)
		let defaultValueWithApiKey = "\(defaultValue)&\(testApiKey)"
		XCTAssert( (requestParamsValueWithApiKey == defaultValueWithApiKey), "requestParamsValue is wrong \(requestParamsValueWithApiKey) != \(defaultValueWithApiKey)")
		
	}
	
	/// Test Hash authentication
	func testAuthenticationHash() {
		// Doc Example hash
		request!.appid = "157";
		request!.ip = "212.45.111.17"
		request!.locale = "de"
		request!.page = "2"
		request!.ps_time = "1312211903"
		request!.pub0 = "campaign2"
		request!.uid = "player1"
		request!.offerTypes = nil
		request!.format = nil
		
		request!.apiKey = "e95a21621a1865bcbae3bee89c4d4f84"
		
		let paramsValue = request!.requestParamsValue(apiKey: false, hashValue: false)
		let normalParamsValue = "appid=\(request!.appid!)&device_id=\(request!.deviceId)&ip=\(request!.ip!)&locale=\(request!.locale!)&page=\(request!.page!)&ps_time=\(request!.ps_time!)&pub0=\(request!.pub0!)&timestamp=\(request!.timestamp)&uid=\(request!.uid!)"
		
		XCTAssert( (paramsValue == normalParamsValue), "paramsValue not good : \(paramsValue) != \(normalParamsValue)")
		
		let hash = self.request!.authenticationHash()
		XCTAssertFalse( hash.isEmpty, "Hash is empty")
		
		let testHash = self.request!.requestParamsValue(apiKey: true, hashValue: false).sha1.lowercaseString
		XCTAssert( (hash == testHash), "Wrong hash : \(hash) != \(testHash)" )
		
		// Change one params and see if hash is different 
		self.request!.page = "3"
		let newHash = self.request!.authenticationHash()
		XCTAssert( (hash != newHash), "Hash don't change : \(hash) != \(newHash)" )
	}
	
	func testCanSendMethod() {
		
		let apiKey = request!.apiKey
		let uid = request!.uid
		
		var (canSend, errorMessage) = request!.canSendRequest();
		XCTAssert( canSend == true, "canSend should be true")
		XCTAssertNil( errorMessage, "errorMessage should be nil")
		
		request!.apiKey = "";
		(canSend, errorMessage) = request!.canSendRequest();
		XCTAssert( canSend == false, "canSend should be true")
		XCTAssertNotNil( errorMessage, "errorMessage shouldn't be nil")
		
		request!.apiKey = apiKey;
		request!.uid = nil;
		(canSend, errorMessage) = request!.canSendRequest();
		XCTAssert( canSend == false, "canSend should be true")
		XCTAssertNotNil( errorMessage, "errorMessage shouldn't be nil")
		
		request!.apiKey = apiKey;
		request!.uid = nil;
		(canSend, errorMessage) = request!.canSendRequest();
		XCTAssert( canSend == false, "canSend should be true")
		XCTAssertNotNil( errorMessage, "errorMessage shouldn't be nil")
		
		request!.uid = uid;
		request!.appid = nil;
		(canSend, errorMessage) = request!.canSendRequest();
		XCTAssert( canSend == false, "canSend should be true")
		XCTAssertNotNil( errorMessage, "errorMessage shouldn't be nil")
		
		
	}

}
