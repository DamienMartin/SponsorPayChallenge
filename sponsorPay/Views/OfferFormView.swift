//
//  FormView.swift
//  sponsorPay
//
//  Created by Damien Martin on 04/10/2014.
//  Copyright (c) 2014 Damien Martin. All rights reserved.
//

import UIKit

protocol OfferFormViewDelegate {
	func formDidValidate(offerRequest: OfferRequest);
}

class OfferFormView: UIView {

	// form input
	var uidTextField: UITextField = UITextField()
	var appIdTextField: UITextField = UITextField()
	var apiKeyTextField: UITextField = UITextField()
	var pub0TextField: UITextField = UITextField()
	// form validator
	var validateButton: UIButton = UIButton();
	
	var delegate: OfferFormViewDelegate?
	
	
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.initialized()
	}
	
	required init(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		self.initialized()
	}
	
	func initialized() {
		var offsetY: Float = 10
		var offsetX: Float = 20
		
		var yPosition: Float = offsetY
		self.uidTextField.formateTextField(self, horizontalOffset: offsetX, verticalPosition: yPosition, placeholder: "UID value")
		
		yPosition += Float(self.uidTextField.frame.size.height) + offsetY
		self.appIdTextField.formateTextField(self, horizontalOffset: offsetX, verticalPosition: yPosition, placeholder: "appID value")
		
		yPosition += Float(self.appIdTextField.frame.size.height) + offsetY
		self.apiKeyTextField.formateTextField(self, horizontalOffset: offsetX, verticalPosition: yPosition, placeholder: "apiKey value")
		
		yPosition += Float(self.apiKeyTextField.frame.size.height) + offsetY
		self.pub0TextField.formateTextField(self, horizontalOffset: offsetX, verticalPosition: yPosition, placeholder: "pub0 value")
		
		// Validate button
		yPosition += Float(self.pub0TextField.frame.size.height) + offsetY
		self.validateButton.frame = CGRectMake(CGFloat(offsetX), CGFloat(yPosition), self.frame.size.width - (2 * CGFloat(offsetX) ), 45)
		self.validateButton.backgroundColor = UIColor.blueColor()
		validateButton.autoresizingMask = UIViewAutoresizing.FlexibleWidth;
		self.validateButton.addTarget(self, action: Selector("validateForm") , forControlEvents: UIControlEvents.TouchUpInside)
		self.validateButton.setTitle("Validate", forState: UIControlState.Normal)
		self.validateButton.setTitleColor(UIColor.grayColor(), forState: UIControlState.Highlighted)
		self.validateButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
		self.addSubview(validateButton);
	}
	
	func validateForm() {
		let request: OfferRequest = self.requestObject()
		if delegate != nil {
			delegate?.formDidValidate(request)
		}
	}
	
	func requestObject() -> OfferRequest {
		return OfferRequest();
	}
	
}
