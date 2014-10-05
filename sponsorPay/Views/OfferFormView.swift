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

class OfferFormView: UIScrollView {

	// form input
	var uidTextField: UITextField = UITextField()
	var appIdTextField: UITextField = UITextField()
	var apiKeyTextField: UITextField = UITextField()
	var pub0TextField: UITextField = UITextField()
	// form validator
	var validateButton: UIButton = UIButton();
	
	
	var loader: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.White);
	var formDelegate: OfferFormViewDelegate?
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.initialized()
	}
	
	required init(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		self.initialized()
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		self.resizeView()
	}
	
	override func traitCollectionDidChange(previousTraitCollection: UITraitCollection) {
		super.traitCollectionDidChange(previousTraitCollection);
		self.resizeView()
	}
	
	func resizeView() {
		var yPosition = Float(self.validateButton.frame.origin.y + self.validateButton.frame.size.height)
		self.contentSize = CGSizeMake(self.frame.size.width, CGFloat(yPosition) + 175 );
		if(contentSize.height > self.bounds.size.height) {
			self.scrollEnabled = true
		}
	}
	
	func initialized() {
		
		self.keyboardDismissMode = UIScrollViewKeyboardDismissMode.Interactive
		
		var offsetY: Float = 10
		var offsetX: Float = 20
		
		var yPosition: Float = offsetY
		self.uidTextField.formateTextField(self, horizontalOffset: offsetX, verticalPosition: yPosition, placeholder: "UID value")
		self.uidTextField.accessibilityLabel = "uidTextField"
		
		yPosition += Float(self.uidTextField.frame.size.height) + offsetY
		self.appIdTextField.formateTextField(self, horizontalOffset: offsetX, verticalPosition: yPosition, placeholder: "appID value")
		self.appIdTextField.accessibilityLabel = "appIdTextField"
		
		yPosition += Float(self.appIdTextField.frame.size.height) + offsetY
		self.apiKeyTextField.formateTextField(self, horizontalOffset: offsetX, verticalPosition: yPosition, placeholder: "apiKey value")
		self.apiKeyTextField.accessibilityLabel = "apiKeyTextField"
		
		yPosition += Float(self.apiKeyTextField.frame.size.height) + offsetY
		self.pub0TextField.formateTextField(self, horizontalOffset: offsetX, verticalPosition: yPosition, placeholder: "pub0 value")
		self.pub0TextField.accessibilityLabel = "pub0TextField"
		
		// Validate button
		yPosition += Float(self.pub0TextField.frame.size.height) + offsetY
		self.validateButton.frame = CGRectMake(CGFloat(offsetX), CGFloat(yPosition), self.frame.size.width - (2 * CGFloat(offsetX) ), 45)
		self.validateButton.isAccessibilityElement = true
		self.validateButton.accessibilityLabel = "validateButton"
		self.validateButton.backgroundColor = UIColor.blueColor()
		validateButton.autoresizingMask = UIViewAutoresizing.FlexibleWidth;
		self.validateButton.addTarget(self, action: Selector("validateForm") , forControlEvents: UIControlEvents.TouchUpInside)
		self.validateButton.setTitle("Validate", forState: UIControlState.Normal)
		self.validateButton.setTitle("", forState: UIControlState.Disabled)
		self.validateButton.setTitleColor(UIColor.grayColor(), forState: UIControlState.Highlighted)
		self.validateButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
		self.addSubview(validateButton)
		
		self.resizeView()
		self.fillTextFieldWithDefaultValue()
	}
	
	func fillTextFieldWithDefaultValue() {
		let request: OfferRequest = self.requestObject()
		if request.uid?.isEmpty	== false	{ self.uidTextField.text = request.uid }
		if request.appid?.isEmpty == false	{ self.appIdTextField.text = request.appid}
		if request.apiKey.isEmpty == false	{ self.apiKeyTextField.text = request.apiKey }
		if request.pub0?.isEmpty == false	{ self.pub0TextField.text = request.pub0 }
	}
	
	func validateForm() {
		let request: OfferRequest = self.requestObject()
		request.uid = self.uidTextField.text
		request.appid = self.appIdTextField.text
		request.apiKey = self.apiKeyTextField.text
		request.pub0 = self.pub0TextField.text
		
		let (canSend, errorMessage: String?) = request.canSendRequest();
		if canSend == true {
			if formDelegate != nil {
				formDelegate!.formDidValidate(request)
			}
		}
		else {
			UIAlertView(title: "Error", message: errorMessage, delegate: nil, cancelButtonTitle: "Ok").show()
		}
	}
	
	func requestObject() -> OfferRequest {
		return OfferRequest();
	}
	
	func disable() {
		self.validateButton.enabled = false
		loader.startAnimating()
		loader.frame = self.validateButton.bounds
		self.validateButton.addSubview(loader)
	}
	
	func enable() {
		loader.removeFromSuperview()
		self.validateButton.enabled = true;
	}
	
}
