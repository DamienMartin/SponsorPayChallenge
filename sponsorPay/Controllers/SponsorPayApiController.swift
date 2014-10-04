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
		return "\(uriString)?\(paramsString)"
	}
	
	func connect(query: OfferRequest, completionHandler handler: ((NSDictionary!) -> Void)!) {
		
		var url: NSURL = NSURL(string: self.uriForRequest(query));
		
		var request1: NSURLRequest = NSURLRequest(URL: url)
		let queue:NSOperationQueue = NSOperationQueue()

		NSURLConnection.sendAsynchronousRequest(request1, queue: queue, completionHandler:{ (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
			var err: NSError
			
			var jsonResult: NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary

			println("Response \(jsonResult)")
			
			handler(jsonResult);
		})
	}
	
}
