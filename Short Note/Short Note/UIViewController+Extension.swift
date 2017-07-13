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
    // trigger alert messages
    func triggerValidationAlert(view : Bool, message : String) {
        if view {
            let alertMessage = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertMessage.addAction(cancelAction)
            present(alertMessage, animated: true, completion: nil)
        }
    }
    
    // trigger alert with ok and cancel actions
    // handler for ok action can be passed as a traling closure
    func triggerDeleteAlert(deleteActionHandler : @escaping () -> Void) {
        
        let alertMessage = UIAlertController(title: nil, message: "Are you sure want to delete the item?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) {_ in
            deleteActionHandler()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertMessage.addAction(okAction)
        alertMessage.addAction(cancelAction)
        self.present(alertMessage, animated: true, completion: nil)
    }

}
