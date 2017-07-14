//
//  SaveUserViewController.swift
//  Short Note
//
//  Created by frank thamel on 7/12/17.
//  Copyright © 2017 Crowderia. All rights reserved.
//

import UIKit
import CoreData

class SaveUserViewController: UIViewController {
    
    // managed object context
    var managedContext : NSManagedObjectContext!
    
    // connecting outlets
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var newPasswordText: UITextField!
    @IBOutlet weak var confirmPasswordText: UITextField!
    @IBOutlet weak var profilePicImageView: UIImageView!
    
    // app delegate
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    // current user
    var currentUser : User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // check current user
        validateUser(managedContext: managedContext)
        
        currentUser = CurrentUser.find(username: appDelegate.currentUser, managedContext: managedContext)
        usernameLabel.text = appDelegate.currentUser
        if let pic = currentUser?.profilePic {
            profilePicImageView.image = UIImage(data: pic as Data)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // change profile pic
    @IBAction func changeProfilePic(_ sender: UITapGestureRecognizer) {
        triggerActionSheetForImagePicker(delegate: self)
    }

    // save user action
    @IBAction func saveUser(_ sender: UIButton) {
        
        // 1
        var result = FormValidator.isEmptyField(newPasswordText.text, withName: "password")
        triggerValidationAlert(view: result.status, message: result.message)
        
        // 2
        if !result.status {
            result = FormValidator.isEmptyField(confirmPasswordText.text, withName: "confirm password")
            triggerValidationAlert(view: result.status, message: result.message)
        }
        
        // 3
        if !result.status {
            result = FormValidator.passwordMismatch(password: newPasswordText.text!.md5(), confirmPassword: confirmPasswordText.text!.md5())
            triggerValidationAlert(view: result.status, message: result.message)
        }
        
        if !result.status {
            do {
                if let user = currentUser {
                    user.password = newPasswordText.text!.md5()
                }
                try managedContext.save()
                signOut()
            } catch let error as NSError {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        }
        
    }
    
    // cancel user update action
    @IBAction func cancelUserUpdate(_ sender: UIButton) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    private func signOut() {
        usernameLabel.text = ""
        let viewController : LogInViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LogInViewController") as! LogInViewController
        viewController.managedContext = managedContext
        self.present(viewController, animated: false, completion: nil)
    }
    
    // hide keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        newPasswordText.endEditing(true)
        confirmPasswordText.endEditing(true)
    }
    
    // hide keyboard when press on return
    @IBAction func textFieldReturn(_ sender: AnyObject) {
        _ = sender.resignFirstResponder()
    }
}

extension SaveUserViewController : UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            profilePicImageView.image = selectedImage
            if let user = currentUser {
                let photoData = UIImagePNGRepresentation(selectedImage)!
                user.profilePic = NSData(data: photoData)
            }
            profilePicImageView.contentMode = .scaleAspectFill
            profilePicImageView.clipsToBounds = true
        }
        
        dismiss(animated: true, completion: nil)
    }
}




