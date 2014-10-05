//
//  Offer.swift
//  sponsorPay
//
//  Created by Damien Martin on 05/10/2014.
//  Copyright (c) 2014 Damien Martin. All rights reserved.
//

import UIKit

class Offer: NSObject {
	

	var title:String?
	var teaser:String?
	var thumbnail:Thumbnail?
	var payout:Int?
	
	
	override init() {
		super.init()
	}
	
	init(dictionary :NSDictionary) {
		self.title = dictionary.objectForKey("title") as? String
		self.teaser = dictionary.objectForKey("teaser") as? String
		if let thumbnailDict = dictionary.objectForKey("thumbnail") as? NSDictionary {
			self.thumbnail = Thumbnail(dictionary: thumbnailDict)
		}
		self.payout = dictionary.objectForKey("payout") as? Int
		super.init()
	}
	
}


class Thumbnail: NSObject {
	
	var lowres: String?
	var hires: String?
	
	init(dictionary :NSDictionary) {
		self.lowres = dictionary.objectForKey("lowres") as? String
		self.hires = dictionary.objectForKey("hires") as? String
		super.init()
	}
}