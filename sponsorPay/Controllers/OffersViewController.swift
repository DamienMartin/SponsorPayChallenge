//
//  OffersViewController.swift
//  sponsorPay
//
//  Created by Damien Martin on 05/10/2014.
//  Copyright (c) 2014 Damien Martin. All rights reserved.
//

import UIKit

class OffersViewController: UITableViewController {

	var offers: [Offer]?
	
	
	//MARK: - Initializer
	init(offers: [Offer]?) {
		super.init();
		self.offers = offers;
	}
	
	override init(style: UITableViewStyle) {
		super.init(style: style);
	}
	
	required init(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder);
	}
	
	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil);
	}
	
	//MARK: - Life cycle
	
	override func viewDidLoad() {
        super.viewDidLoad()

		// Define xib for cell
		var nipName = UINib(nibName: "OfferTableViewCell", bundle:nil)
		self.tableView.registerNib(nipName, forCellReuseIdentifier: "offer")
		
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
	//MARK: - UITableViewDelegate + UITableViewDatasource
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if offers != nil {
			return offers!.count
		}
		return 0;
	}
	
	override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		return 150
	}
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		var cell = tableView.dequeueReusableCellWithIdentifier("offer") as OfferTableViewCell;
		
		let offer: Offer = self.offers![indexPath.row] as Offer
		cell.refreshView(offer)
		
		
		return cell;
	}
	
	
	
	
}
