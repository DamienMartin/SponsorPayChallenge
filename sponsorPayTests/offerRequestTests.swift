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
	
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testOrderedParams() {
		var request: OfferRequest = OfferRequest();
		let paramsOrdered: NSArray = request.orderedParams()
		
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

//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measureBlock() {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
