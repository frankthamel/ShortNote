//
//  SaveLanguageViewController.swift
//  Short Note
//
//  Created by frank thamel on 7/12/17.
//  Copyright © 2017 Crowderia. All rights reserved.
//

import UIKit
import CoreData

class SaveLanguageViewController: UIViewController {
    
    // managed object context
    var managedContext : NSManagedObjectContext!
    
    // connecting outlets
    @IBOutlet weak var languageText: UITextField!
    
    // language only for update
    var language: ProgrammingLanguage?
    
    private let backToLanguageListSegue : String = "unwindToMenu"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let newLanguage = language {
            languageText.text = newLanguage.name!
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // save language
    @IBAction func saveLanguage(_ sender: UIButton) {
        
        // 1
        let result = FormValidator.isEmptyField(languageText.text, withName: "language")
        triggerValidationAlert(view: result.status, message: result.message)

        if !result.status {
            do {
                if let newLanguage = language {
                    newLanguage.name = languageText.text!
                } else {
                    let entity = ProgrammingLanguage(context: managedContext)
                    entity.name = languageText.text!
                }
                try managedContext.save()
                languageText.text = ""
                
                // navigate to language list page
                performSegue(withIdentifier: backToLanguageListSegue, sender: self)
                
            } catch let error as NSError {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
    
    // cancel
    @IBAction func cancel(_ sender: UIButton) {
        performSegue(withIdentifier: backToLanguageListSegue, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == backToLanguageListSegue {
            let destinationController = segue.destination as! LanguagesViewController
            destinationController.managedContext = managedContext
        }
    }

}
