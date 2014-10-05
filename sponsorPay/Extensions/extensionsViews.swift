//
//  extensionsViews.swift
//  sponsorPay
//
//  Created by Damien Martin on 04/10/2014.
//  Copyright (c) 2014 Damien Martin. All rights reserved.
//

import UIKit

let uitextfieldHeight: CGFloat = 33;


extension UITextField {
	
	/// This function :
	/// - prepare UITextField to be presented on the form
	/// - insert on parentView (param) the UITextField
	func formateTextField(parentView: UIView, horizontalOffset offsetX: Float, verticalPosition yPosition: Float, placeholder textPlaceholder: String) {
		
		self.frame = CGRectMake(CGFloat(offsetX), CGFloat(yPosition), parentView.frame.size.width - ( 2 * CGFloat(offsetX) ), uitextfieldHeight)
		
		self.placeholder = textPlaceholder
		self.autoresizingMask = UIViewAutoresizing.FlexibleWidth|UIViewAutoresizing.FlexibleBottomMargin
		
		self.borderStyle = UITextBorderStyle.RoundedRect
		self.font = UIFont.systemFontOfSize(15)
		self.autocorrectionType = UITextAutocorrectionType.No
		self.keyboardType = UIKeyboardType.Default
		self.returnKeyType = UIReturnKeyType.Done
		self.clearButtonMode = UITextFieldViewMode.WhileEditing
		self.contentVerticalAlignment = UIControlContentVerticalAlignment.Center
		self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
		
		parentView.addSubview(self);
	}
}