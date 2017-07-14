//
//  LanguagesViewController.swift
//  Short Note
//
//  Created by frank thamel on 7/12/17.
//  Copyright © 2017 Crowderia. All rights reserved.
//

import UIKit
import CoreData

class LanguagesViewController: UIViewController {
    
    // managed object context
    var managedContext : NSManagedObjectContext!
    
    @IBOutlet weak var languagesTableView: UITableView!
    
    fileprivate let cellIdentifier : String = "LanguageCell"
    fileprivate var programmingLanguages : [ProgrammingLanguage] = []
    fileprivate let addLanguageSegue : String = "newLanguageSegue"
    fileprivate let goToNotesSegue : String = "goToNotesSegue"
    fileprivate var selectedLanguage :  ProgrammingLanguage? = nil // need to set in row select

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // check current user
        validateUser(managedContext: managedContext)
        
        loadLanguages()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadLanguages()
        languagesTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func addLanguages(_ sender: UIBarButtonItem) {
        selectedLanguage = nil
        performSegue(withIdentifier: addLanguageSegue, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == addLanguageSegue {
            let destinationController = segue.destination as! SaveLanguageViewController
            destinationController.managedContext = managedContext
            destinationController.language = selectedLanguage
        }
        
        if segue.identifier == goToNotesSegue {
             let destinationController = segue.destination as! ShortNotesViewController
            destinationController.managedContext = managedContext
            destinationController.programmingLanguage = selectedLanguage!
        }
    }
    
    @IBAction func unwindToMenu(segue : UIStoryboardSegue){}
}

extension LanguagesViewController : UITableViewDataSource , UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return programmingLanguages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! LanguagesTableViewCell
        let languageName : String = programmingLanguages[indexPath.row].name!.uppercased()
        cell.languageNameFirstLetterLabel.text = String(languageName[languageName.startIndex])
        cell.languageNameLabel.text = programmingLanguages[indexPath.row].name!
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedLanguage = programmingLanguages[indexPath.row]
        performSegue(withIdentifier: goToNotesSegue, sender: self)
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        // update action
        let updateAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "Update", handler: {(action , indexPath) -> Void in
            self.selectedLanguage = self.programmingLanguages[indexPath.row]
            self.performSegue(withIdentifier: self.addLanguageSegue, sender: self)
        })
        
        // delete action
        let deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "Delete", handler: {(action , indexPath) -> Void in
            // delete the row
            self.triggerDeleteAlert {
                
                // call delete function
                if self.delete(language: self.programmingLanguages[indexPath.row]) {
                    print("deleting row.")
                    self.programmingLanguages.remove(at: indexPath.row)
                    self.languagesTableView.deleteRows(at: [indexPath], with: .fade)
                }
            }
        })
        
        // set action background colors
        updateAction.backgroundColor = StandardColors.BLUE
        deleteAction.backgroundColor = StandardColors.RED
        
        return [deleteAction , updateAction]
    }
}

// load languages from database
extension LanguagesViewController {
   fileprivate func loadLanguages() {
        let fetch : NSFetchRequest<ProgrammingLanguage> = ProgrammingLanguage.fetchRequest()
        
        do {
            let results = try managedContext.fetch(fetch)
            if results.count > 0 {
                programmingLanguages = results
            }
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
    
    // delete data
   fileprivate func delete(language : ProgrammingLanguage) -> Bool {
        managedContext.delete(language)
        
        do {
            try managedContext.save()
            return true
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
            return false
        }
    }
}





