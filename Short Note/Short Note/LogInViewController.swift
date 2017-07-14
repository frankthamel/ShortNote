//
//  LogInViewController.swift
//  Short Note
//
//  Created by frank thamel on 7/11/17.
//  Copyright © 2017 Crowderia. All rights reserved.
//

import UIKit
import CryptoSwift
import CoreData

class LogInViewController: UIViewController {
    
    // managed object context
    internal var managedContext : NSManagedObjectContext!
    
    // connecting form feilds
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    private let successLoginSegue : String = "successLoginSegue"
    private let createUserSegue : String = "createUserSegue"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // adding sample programming languages only for first time app launch
        SampleDataCreator.insertSampleData(managedContext: managedContext)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // block walkthrough scrrens if viewd once
        if UserDefaults.standard.bool(forKey: "viewedWalkthrough") {
            return
        }
        
        // load walkthrough screens
        if let pageViewController = storyboard?.instantiateViewController(withIdentifier: "WalkthroughPageViewController") as? WalkthroughPageViewController {
            present(pageViewController, animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Sign in button action
    @IBAction func signIn(_ sender: UIButton) {
        // 1
        var result = FormValidator.isEmptyField(usernameText.text, withName: "username")
        triggerValidationAlert(view: result.status, message: result.message)
        
        // 2
        if !result.status {
            result = FormValidator.isEmptyField(passwordText.text, withName: "password")
            triggerValidationAlert(view: result.status, message: result.message)
        }
        
        // user authentication
        if !result.status {
            let authenticate = UserAuthentication.authenticate(user: usernameText.text!, encryptedPassword: passwordText.text!.md5(), managedContext: managedContext)
            triggerValidationAlert(view: !authenticate.status, message: authenticate.message)
            
            if authenticate.status {
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.currentUser = usernameText.text!
                performSegue(withIdentifier: successLoginSegue, sender: self)
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        usernameText.endEditing(true)
        passwordText.endEditing(true)
    }
    
    @IBAction func textFieldReturn(_ sender: AnyObject) {
        _ = sender.resignFirstResponder()
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == successLoginSegue {
            let barViewControllers = segue.destination as! UITabBarController
            let nav = barViewControllers.viewControllers![0] as! UINavigationController
            let destinationViewController = nav.topViewController as! LanguagesViewController
            destinationViewController.managedContext = managedContext
            
            let nav1 = barViewControllers.viewControllers![1] as! UINavigationController
            let destinationViewController1 = nav1.topViewController as! SaveNoteViewController
            destinationViewController1.managedContext = managedContext
            
            let nav2 = barViewControllers.viewControllers![2] as! UINavigationController
            let destinationViewController2 = nav2.topViewController as! CurrentUserViewController
            destinationViewController2.managedContext = managedContext
        }
        
        if segue.identifier == createUserSegue {
            let destinationController = segue.destination as! CreateUserViewController
            destinationController.managedContext = managedContext
        }
    }
}
