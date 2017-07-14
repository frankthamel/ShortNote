//
//  CurrentUserViewController.swift
//  Short Note
//
//  Created by frank thamel on 7/12/17.
//  Copyright © 2017 Crowderia. All rights reserved.
//

import UIKit
import CoreData

class CurrentUserViewController: UIViewController {
    
    // managed object context
    internal var managedContext : NSManagedObjectContext!
    
    // connecting outlets
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var profilePicImageView: UIImageView!
    
    // edit user segue
    private let editUserSegue : String = "editUserSegue"
    
    // app delegate
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // check current user
        validateUser(managedContext: managedContext)
        
        usernameLabel.text = appDelegate.currentUser
        
        let currentUser = CurrentUser.find(username: appDelegate.currentUser, managedContext: managedContext)
        if let pic = currentUser?.profilePic {
            profilePicImageView.image = UIImage(data: pic as Data)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // log out action
    @IBAction func signOut(_ sender: UIButton) {
        usernameLabel.text = ""
        let viewController : LogInViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LogInViewController") as! LogInViewController
        viewController.managedContext = managedContext
        self.present(viewController, animated: false, completion: nil)
    }
    
    @IBAction func editUser(_ sender: UIBarButtonItem) {
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == editUserSegue {
            let destinationController = segue.destination as! SaveUserViewController
            destinationController.managedContext = managedContext
        }
    }
}
