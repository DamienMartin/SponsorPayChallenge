//
//  OffersResponse.swift
//  sponsorPay
//
//  Created by Damien Martin on 05/10/2014.
//  Copyright (c) 2014 Damien Martin. All rights reserved.
//

import UIKit

class OffersResponse: NSObject {
 
	var offers: [Offer]?
	
	
	var urlResponse: NSHTTPURLResponse
	var data: NSData
	
	override init() {
		self.urlResponse = NSHTTPURLResponse();
		self.data = NSData();
		super.init()
	}
	
	init(urlResponse response:NSHTTPURLResponse, responseData data:NSData) {
		self.urlResponse = response;
		self.data = data;
		super.init()
	}
	
	func isResponseCorrect() -> Bool {
		if let responseHash: String = self.urlResponse.allHeaderFields[headerHTTPResponseHash] as? NSString {
			
			// Check if is correct hash
			let responseString = NSString(data: data, encoding: NSUTF8StringEncoding)
			let valueToHash = "\(responseString)\(defaultApiKey)" as NSString
			let bodyHash = valueToHash.sha1
			
			if bodyHash == responseHash {
				return true
			}
		}
		return false
	}
	
	func offersInResponse() -> [Offer]? {
		let jsonResult = NSJSONSerialization.JSONObjectWithData(self.data, options: NSJSONReadingOptions.MutableContainers, error: nil) as? NSDictionary
		let dictOffers: NSArray? = jsonResult?.objectForKey("offers") as? NSArray;
		
		if dictOffers != nil {
			
			var offers: [Offer] = []
			
			dictOffers?.enumerateObjectsUsingBlock({ (object , idx, stop) -> Void in
				if let dictOffer = object as? NSDictionary {
					let offer = Offer(dictionary: dictOffer)
					offers.append(offer);
				}
			})
			
			return offers
		}
		return nil
	}

	
}
