//
//  offerRequest.swift
//  sponsorPay
//
//  Created by Damien Martin on 04/10/2014.
//  Copyright (c) 2014 Damien Martin. All rights reserved.
//

import UIKit

class OfferRequest: NSObject {
	
	/* private */
	private var apiKey: String = defaultApiKey;
	
	/* request Params */
	var format: String? =  defaultFormat
	var appid: String? =  defaultAppId
	var uid: String? = defaultUid
	var locale: String? = defaultLocale
	var ip: String? = defaultIp
	var offerTypes: String? = defaultOfferTypes;
	var appleIdfa: String?
	var deviceId: String?
	var page: String?
	var ps_time: String?
	var pub0: String?
	var timestamp: String?
	
	override init() {
		super.init();
	}
	
	/// Return ordered URL params (except hash)
	func orderedParams() -> NSArray {
		var params: NSMutableDictionary = NSMutableDictionary();
		if self.format != nil { params.setObject(self.format!, forKey: "format") }
		if self.appid != nil { params.setObject(self.appid!, forKey: "appid") }
		if self.uid != nil { params.setObject(self.uid!, forKey: "uid") }
		if self.locale != nil { params.setObject(self.locale!, forKey: "locale") }
		if self.ip != nil { params.setObject(self.ip!, forKey: "ip") }
		if self.offerTypes != nil { params.setObject(self.offerTypes!, forKey: "offer_types") }
		if self.appleIdfa != nil { params.setObject(self.appleIdfa!, forKey: "apple_idfa") }
		if self.deviceId != nil { params.setObject(self.deviceId!, forKey: "device_id") }
		if self.page != nil { params.setObject(self.page!, forKey: "page") }
		if self.ps_time != nil { params.setObject(self.ps_time!, forKey: "ps_time") }
		if self.pub0 != nil { params.setObject(self.pub0!, forKey: "pub0") }
		if self.timestamp != nil { params.setObject(self.timestamp!, forKey: "timestamp") }
	

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
	
	/// Return concat URL params string (except hash)
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
	
	func authenticationHash() -> String {
		let paramsValue = self.requestParamsValue();
		let valueToHash: NSString = "\(paramsValue)&\(self.apiKey)" as NSString
		
		return valueToHash.sha1;
	}
	
	/// Only use for test
	func setApiKey(apiKey newApiKey:String) {
		apiKey = newApiKey;
	}
}
