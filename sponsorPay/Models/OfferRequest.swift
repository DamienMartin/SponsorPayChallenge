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
	var deviceId: String
	var page: String?
	var ps_time: String?
	var pub0: String?
	
	var fixedTimestamp: String?
	var timestamp: String {
		get {
			if fixedTimestamp == nil { self.fixedTimestamp = NSDate().timeIntervalSince1970.description }
			return self.fixedTimestamp!
		}
		set {
			self.timestamp = newValue
		}
	}
	
	override init() {
		self.deviceId = ASIdentifierManager.sharedManager().advertisingIdentifier.UUIDString
		super.init()
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
		if self.page != nil { params.setObject(self.page!, forKey: "page") }
		if self.ps_time != nil { params.setObject(self.ps_time!, forKey: "ps_time") }
		if self.pub0 != nil { params.setObject(self.pub0!, forKey: "pub0") }
		params.setObject(self.deviceId, forKey: "device_id")
		params.setObject(self.timestamp, forKey: "timestamp")
	

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
	func requestParamsValue(apiKey apiKeyDisplayed:Bool, hashValue hashValueDisplayed:Bool) -> String {
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
		
		// Add apiKey if is asked
		if(apiKeyDisplayed) {
			if paramsValue.isEmpty { paramsValue = self.apiKey }
			else { paramsValue += "&\(self.apiKey)" }
		}
		
		if(hashValueDisplayed) {
			let hashParam = "hashkey=\(self.authenticationHash())"
			if paramsValue.isEmpty { paramsValue = hashParam }
			else { paramsValue += "&\(hashParam)" }
		}
		
		return paramsValue;
	}
	
	/// return authentication hash for the request
	func authenticationHash() -> String {
		let valueToHash = self.requestParamsValue(apiKey: true, hashValue: false);
		return valueToHash.sha1.lowercaseString;
	}
	
	/// Only use for test
	func setApiKey(apiKey newApiKey:String) {
		apiKey = newApiKey;
	}
	
}
