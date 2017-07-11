//
//  FTView.swift
//  Short Note
//
//  Created by frank thamel on 7/11/17.
//  Copyright © 2017 Crowderia. All rights reserved.
//

import UIKit

@IBDesignable
class FTView: UIView {
    @IBInspectable var cornerRadius : CGFloat = 10.0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    
    @IBInspectable var borderWidth : CGFloat = 0.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor : UIColor = .white {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
}
