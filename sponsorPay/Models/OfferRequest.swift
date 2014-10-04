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
	var appleIdfa: String {
		get {
			return "TEST"
		}
	}
	
	override init() {
		super.init();
	}
	
	func requestParamsValue() -> String {
		let paramsOrdered = self.orderedParams();
		
		var paramsValue: String = "";
		paramsOrdered.enumerateObjectsUsingBlock { (object: AnyObject!, idx, stop) -> Void in
			let param = object as NSDictionary;
			
			if !paramsValue.isEmpty {
				paramsValue += "&"
			}
			
			if let key = param.allKeys.first as? String {
				if let value = param.objectForKey(key) as? String {
					paramsValue += "\(key)=\(value)"
				}
			}
		}
		
		return paramsValue;
	}
	
	func orderedParams() -> NSArray {
		var params: NSMutableDictionary = NSMutableDictionary();
		params.setObject(self.format, forKey: "format");
		params.setObject(self.appid, forKey: "appid");
		params.setObject(self.uid, forKey: "uid");
		params.setObject(self.locale, forKey: "locale");
		params.setObject(self.ip, forKey: "ip");
		params.setObject(self.offerTypes, forKey: "offer_types");
		params.setObject(self.appleIdfa, forKey: "apple_idfa");

		
		var paramsToReturn: NSMutableArray = NSMutableArray();
		
		let allKeys: [String] = params.allKeys as [String];
		let allKeysOrdered = allKeys.sorted { (s1, s2) -> Bool in
			return s1 < s2
		}
		
		for key in allKeysOrdered as [String] {
			if let value = params.objectForKey(key) as? String {
				let paramToAdd: NSDictionary = NSDictionary(object: value, forKey: key);
				paramsToReturn.addObject(paramToAdd);
			}
		}
		
		return paramsToReturn
	}
	
}
