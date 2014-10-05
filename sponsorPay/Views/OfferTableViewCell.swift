//
//  OfferTableViewCell.swift
//  sponsorPay
//
//  Created by Damien Martin on 05/10/2014.
//  Copyright (c) 2014 Damien Martin. All rights reserved.
//

import UIKit

class OfferTableViewCell: UITableViewCell {

	@IBOutlet var title: UILabel?
	@IBOutlet var teaser: UILabel?
	@IBOutlet var thumbnail: UIImageView?
	@IBOutlet var payout: UILabel?
	

	var imageDownloadTask: NSURLSessionDataTask?
	var session: NSURLSession = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
	
	func refreshView(offer: Offer) {
		
		self.title?.text = offer.title
		self.teaser?.text = offer.teaser
		self.payout?.text = offer.payout?.description
		self.downloadAndDisplayImage(offer.thumbnail?.hires)
	}
	
	func downloadAndDisplayImage(urlString: String?) {
		if urlString != nil {
			if self.imageDownloadTask != nil {
				self.imageDownloadTask?.cancel();
			}
			
			self.thumbnail?.image = nil;
			
			let imageURL = NSURL(string: urlString!)
			
			self.imageDownloadTask = self.session.dataTaskWithURL(imageURL, completionHandler: { (data, response, error) -> Void in
				if error != nil {
					println("Error \(error.description)")
				}
				else {
					let httpResponse: NSHTTPURLResponse = response as NSHTTPURLResponse;
					if httpResponse.statusCode == 200 {
						
						NSOperationQueue.mainQueue().addOperationWithBlock() {
							let image: UIImage = UIImage(data: data)
							self.thumbnail?.image = image;
						}
					}
					else {
						println("Could not load image .. ")
					}
				}
			})
			
			self.imageDownloadTask?.resume()
		}
	}

	
}
