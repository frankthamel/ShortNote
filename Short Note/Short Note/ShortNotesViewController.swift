//
//  ShortNotesViewController.swift
//  Short Note
//
//  Created by frank thamel on 7/12/17.
//  Copyright © 2017 Crowderia. All rights reserved.
//

import UIKit
import CoreData

class ShortNotesViewController: UIViewController {
    
    // managed object context
    var managedContext : NSManagedObjectContext!
    
    @IBOutlet weak var tableView: UITableView!
    
    // reusable table prototype cell
    fileprivate let cellIdentifier : String = "ShortNoteCell"
    
    // selected programming language
    var programmingLanguage : ProgrammingLanguage!
    
    // storing loaded notes
    fileprivate var notes : [ShortNote] = []
    
    // set selected note
    fileprivate var selectedNote : ShortNote?
    
    // note view segue
    fileprivate let goToNoteSegue : String = "noteViewSegue"
    
    // update note segue
    fileprivate let editNoteSegue : String = "editNoteSegue"
    
    // reusable date formatter
    fileprivate let formatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // check current user
        validateUser(managedContext: managedContext)
        
        self.title = "\(programmingLanguage.name!) - Notes"
        
        // set date format
        formatter.dateFormat = "dd.MM.yyyy"
        
        // load notes
        loadNotes()
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // load notes
        loadNotes()
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == goToNoteSegue {
            let destinationController = segue.destination as! ShortNoteViewController
            destinationController.managedContext = managedContext
            destinationController.note = selectedNote
        }
        
        if segue.identifier == editNoteSegue {
            let destinationController = segue.destination as! SaveNoteViewController
            destinationController.managedContext = managedContext
            destinationController.selectedLanguage = selectedNote?.language
            destinationController.noteForEdit = selectedNote
            destinationController.isEdit = true
        }
    }
    
    @IBAction func unwindToMenu(segue : UIStoryboardSegue){}
 
}


extension ShortNotesViewController : UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ShortNotesTableViewCell
        
        let note = notes[indexPath.row]
        
        cell.noteNumberLabel.text = "\(indexPath.row)"
        cell.noteTitleLabel.text = note.title
        cell.noteCreatedDateLabel.text = formatter.string(from: note.date! as Date)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedNote = notes[indexPath.row]
        performSegue(withIdentifier: goToNoteSegue, sender: self)
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        // update action
        let updateAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "Update", handler: {(action , indexPath) -> Void in
            self.selectedNote = self.notes[indexPath.row]
            self.performSegue(withIdentifier: self.editNoteSegue, sender: self)
        })
        
        // delete action
        let deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "Delete", handler: {(action , indexPath) -> Void in
            // delete the row
            self.triggerDeleteAlert {
                
                // call delete function
                if self.delete(note: self.notes[indexPath.row]) {
                    print("deleting row.")
                    self.notes.remove(at: indexPath.row)
                    self.tableView.deleteRows(at: [indexPath], with: .fade)
                }
            }
        })
        
        // set action background colors
        updateAction.backgroundColor = StandardColors.BLUE
        deleteAction.backgroundColor = StandardColors.RED
        
        return [deleteAction , updateAction]
    }
}

// handling database operations
extension ShortNotesViewController {
    fileprivate func loadNotes() {
        let fetch : NSFetchRequest<ShortNote> = ShortNote.fetchRequest()
        fetch.predicate = NSPredicate(format: "%K == %@", #keyPath(ShortNote.language), programmingLanguage)
        
        do {
            let results = try managedContext.fetch(fetch)
            if results.count > 0 {
                notes = results
            }
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
    
    // delete data
    fileprivate func delete(note : ShortNote) -> Bool {
        managedContext.delete(note)
        
        do {
            try managedContext.save()
            return true
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
            return false
        }
    }
}
