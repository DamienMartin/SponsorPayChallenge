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
	
	func connect(query:String, completionHandler handler: ((NSDictionary!) -> Void)!) {
		
		let queryString: String = self.uriForEndPoint(SponsorPayEndPoint.Offers);
		
		NSLog("URL : \(queryString) ");
		var url: NSURL = NSURL(string: queryString)
		var request1: NSURLRequest = NSURLRequest(URL: url)
		let queue:NSOperationQueue = NSOperationQueue()
		
		NSURLConnection.sendAsynchronousRequest(request1, queue: queue, completionHandler:{ (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
			/* Your code */
			
			var err: NSError
			
			//Todo : crash if nil !!!!
			
			var jsonResult: NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
			println("AsSynchronous\(jsonResult)")
			handler(jsonResult);
		})
	}

	
}
