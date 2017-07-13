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
    
    // trigger action sheet for image picker
    func triggerActionSheetForImagePicker(delegate : UIImagePickerControllerDelegate) {
        let optionMenu = UIAlertController(title: nil, message: "Pick Image", preferredStyle: .actionSheet)
        
        // pick image from photo library
        let pickFromPhotoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { _ in
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = delegate as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
                imagePicker.allowsEditing = false
                imagePicker.sourceType = .photoLibrary
                self.present(imagePicker, animated: true, completion: nil)
            }
        }
        optionMenu.addAction(pickFromPhotoLibraryAction)
        
        // pick image from camera
        let pickFromCameraAction = UIAlertAction(title: "Camera", style: .default) { _ in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = delegate as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
                imagePicker.allowsEditing = false
                imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true, completion: nil)
            }
        }
        optionMenu.addAction(pickFromCameraAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        optionMenu.addAction(cancelAction)
        present(optionMenu, animated: true, completion: nil)
    }

}
