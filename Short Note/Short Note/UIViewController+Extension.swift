//
//  UIViewController+Extension.swift
//  Short Note
//
//  Created by frank thamel on 7/12/17.
//  Copyright © 2017 Crowderia. All rights reserved.
//

import Foundation
import UIKit


extension UIViewController {
    func triggerValidationAlert(view : Bool, message : String) {
        if view {
            let aleartMenu = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            aleartMenu.addAction(cancelAction)
            present(aleartMenu, animated: true, completion: nil)
        }
    }
}
