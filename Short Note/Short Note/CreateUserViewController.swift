//
//  CreateUserViewController.swift
//  Short Note
//
//  Created by frank thamel on 7/12/17.
//  Copyright © 2017 Crowderia. All rights reserved.
//

import UIKit
import CoreData

class CreateUserViewController: UIViewController {
    
    // managed object context
    var managedContext : NSManagedObjectContext!
    
    // connecting form text feilds
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var confirmPasswordText: UITextField!
    @IBOutlet weak var profilePicImageView: UIImageView!
    
    fileprivate var isPhotoAdded : Bool = false
    
    private let signUpToLogInSegue : String = "SignUpToLogInSegue"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // register new user action
    @IBAction func createNewUser(_ sender: UIButton) {
        // 1
        var result = FormValidator.isEmptyField(usernameText.text, withName: "username")
        triggerValidationAlert(view: result.status, message: result.message)

        // 2
        if !result.status {
            result = FormValidator.isEmptyField(passwordText.text, withName: "password")
            triggerValidationAlert(view: result.status, message: result.message)
        }

        // 3
        if !result.status {
            result = FormValidator.isEmptyField(confirmPasswordText.text, withName: "confirm password")
            triggerValidationAlert(view: result.status, message: result.message)
        }

        // 4
        if !result.status {
            result = FormValidator.passwordMismatch(password: passwordText.text!.md5(), confirmPassword: confirmPasswordText.text!.md5())
            triggerValidationAlert(view: result.status, message: result.message)
        }

        // 5
        if !result.status {
            result = FormValidator.usernameTaken(username: usernameText.text!, managedContext: managedContext)
            triggerValidationAlert(view: result.status, message: result.message)
        }

        if !result.status {
            do {
                let newUser = User(context: managedContext)
                newUser.username = usernameText.text!
                newUser.password = passwordText.text!.md5()
                if isPhotoAdded {
                    if let image = profilePicImageView.image {
                        let photoData = UIImagePNGRepresentation(image)!
                        newUser.profilePic = NSData(data: photoData)
                    }
                }
                
                try managedContext.save()
            } catch let error as NSError {
                print("Unresolved error \(error), \(error.userInfo)")
            }
            performSegue(withIdentifier: signUpToLogInSegue, sender: self)
        }
 
    }
    
    // add profile pic
    @IBAction func addProfilePic(_ sender: UITapGestureRecognizer) {
        triggerActionSheetForImagePicker(delegate: self)
    }

    // navigate to login screen
    @IBAction func cancelUserCreation(_ sender: UIButton) {
        performSegue(withIdentifier: signUpToLogInSegue, sender: self)
    }
    
    // hide keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        usernameText.endEditing(true)
        passwordText.endEditing(true)
        confirmPasswordText.endEditing(true)
    }
    
    // hide keyboard when press on return
    @IBAction func textFieldReturn(_ sender: AnyObject) {
        _ = sender.resignFirstResponder()
    }
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == signUpToLogInSegue {
            let destinationController = segue.destination as! LogInViewController
            destinationController.managedContext = managedContext
        }
    }
}


extension CreateUserViewController : UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            profilePicImageView.image = selectedImage
            profilePicImageView.contentMode = .scaleAspectFill
            profilePicImageView.clipsToBounds = true
            isPhotoAdded = true
        }
        
        dismiss(animated: true, completion: nil)
    }
}
