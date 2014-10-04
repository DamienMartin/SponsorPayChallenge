//
//  SponsorPayApiController.swift
//  sponsorPay
//
//  Created by Damien Martin on 04/10/2014.
//  Copyright (c) 2014 Damien Martin. All rights reserved.
//

import UIKit

enum SponsorPayEndPoint {
	case Offers
}

class SponsorPayApiController: NSObject {
 
	var data = NSMutableData()
	
	func uriForEndPoint(endPoint: SponsorPayEndPoint) -> String {
		var uri = "http://\(apiDomainName)\(apiUri)";
		switch (endPoint) {
		case .Offers :
			uri += "\(apiOffersEndPoint)"
			break;
		default:
			break;
		}
		return uri;
	}
	
	func uriForRequest(query: OfferRequest) -> String {
		let uriString: String = self.uriForEndPoint(SponsorPayEndPoint.Offers)
		let paramsString: String = query.requestParamsValue(apiKey: false, hashValue: true)
		let uriForRequest = "\(uriString)?\(paramsString)"
		
		return uriForRequest
	}
	
	func getOffers(query: OfferRequest, completionHandler handler: ((NSDictionary!, error: NSString?) -> Void)!) {
		
		var url: NSURL = NSURL(string: self.uriForRequest(query));
		
		var request1: NSURLRequest = NSURLRequest(URL: url)
		let queue:NSOperationQueue = NSOperationQueue()

		NSURLConnection.sendAsynchronousRequest(request1, queue: queue, completionHandler:{ (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
			var err: NSError
			
			var errorMessage: String?
			var jsonResult: NSDictionary?
			
			// Get hash header response
			if self.checkResponse(data, response: response) == true {
				jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as? NSDictionary
			}
			else {
				errorMessage = "invalid server response ..."
			}

			NSOperationQueue.mainQueue().addOperationWithBlock() {
				handler(jsonResult, error: errorMessage);
			}
		})
	}
	
	func checkResponse(data: NSData!, response:NSURLResponse) -> Bool {
		let responseHttp = response as NSHTTPURLResponse
		if let responseHash: String = responseHttp.allHeaderFields[headerHTTPResponseHash] as? NSString {
			
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
	
}
