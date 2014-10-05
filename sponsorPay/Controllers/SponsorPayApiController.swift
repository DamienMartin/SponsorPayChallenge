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
	
	func getOffers(query: OfferRequest, completionHandler handler: (([Offer]?, error: NSString?) -> Void)!) {
		
		let (canSend, errorMessage: String?) = query.canSendRequest();
		if canSend == true {
			
			var url: NSURL = NSURL(string: self.uriForRequest(query));
			
			var request1: NSURLRequest = NSURLRequest(URL: url)
			let queue:NSOperationQueue = NSOperationQueue()
			
			NSURLConnection.sendAsynchronousRequest(request1, queue: queue, completionHandler:{ (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
				var err: NSError
				
				var errorMessage: String?
				var offers: [Offer]?
				
				let offersResponse: OffersResponse = OffersResponse(urlResponse: response as NSHTTPURLResponse, responseData: data)
				if offersResponse.isResponseCorrect() == true {
					offers = offersResponse.offersInResponse();
				}
				else {
					errorMessage = "Invalid server response"
				}
				NSOperationQueue.mainQueue().addOperationWithBlock() {
					handler(offers, error: errorMessage);
				}
			})
		}
		else {
			NSOperationQueue.mainQueue().addOperationWithBlock() {
				handler(nil, error: "Incorrect query : Missing params");
			}
		}
	}
}
