//
//  offerRequest.swift
//  sponsorPay
//
//  Created by Damien Martin on 04/10/2014.
//  Copyright (c) 2014 Damien Martin. All rights reserved.
//

import UIKit

class OfferRequest: NSObject {
	
	/* request Params */
	var format: String =  defaultFormat
	var appid: String =  defaultAppId
	var uid: String = defaultUid
	var locale: String = defaultLocale
	var ip: String = defaultIp
	var offerTypes: String = defaultOfferTypes;
	var apple_idfa: String?
	
	override init() {
		super.init();
	}
	
	func orderedParams() -> NSArray {
		var params: NSMutableDictionary = NSMutableDictionary();
		params.setObject(self.format, forKey: "format");
		
		var paramsToReturn: NSMutableArray = NSMutableArray();
		
		for key in params.allKeys as [String] {
			if let value = params.objectForKey(key) as? String {
				let paramToAdd: NSDictionary = NSDictionary(object: value, forKey: key);
				paramsToReturn.addObject(paramToAdd);
			}
		}
		
		return paramsToReturn
	}
	
}
