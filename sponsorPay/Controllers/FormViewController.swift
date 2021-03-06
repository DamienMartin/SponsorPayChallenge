//
//  ViewController.swift
//  sponsorPay
//
//  Created by Damien Martin on 04/10/2014.
//  Copyright (c) 2014 Damien Martin. All rights reserved.
//

import UIKit

class FormViewController: UIViewController, OfferFormViewDelegate {

	@IBOutlet var contentView: UIScrollView?
	@IBOutlet var form: OfferFormView?
	
	required init(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder);
	}
	
	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil);
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.navigationController?.hidesBarsWhenKeyboardAppears = true;
		self.navigationController?.hidesBarsWhenVerticallyCompact = true;
		form?.formDelegate = self
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


	// MARK: - OfferFormViewDelegate
	func formDidValidate(offerRequest: OfferRequest) {
		self.form?.disable();
		
		let apiController: SponsorPayApiController = SponsorPayApiController();
		apiController.getOffers(offerRequest, completionHandler: { (result, error) -> Void in
			if error != nil {
				let alert: UIAlertView = UIAlertView(title: "Error", message: error!, delegate: nil, cancelButtonTitle: "Ok");
				alert.show();
			}
			else {
				if result!.count == 0 {
					UIAlertView(title: "We're sorry", message: "No offers found", delegate: nil, cancelButtonTitle: "Ok");
				}
				else {
					let vc: OffersViewController = OffersViewController(offers: result!)
					self.navigationController?.pushViewController(vc, animated: true)
				}
			}
			self.form?.enable();
		})
	}
	
}

