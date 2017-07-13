//
//  SaveNoteViewController.swift
//  Short Note
//
//  Created by frank thamel on 7/12/17.
//  Copyright © 2017 Crowderia. All rights reserved.
//

import UIKit
import CoreData

class SaveNoteViewController: UIViewController {
    
    // managed object context
    var managedContext : NSManagedObjectContext!
    
    // connecting outlets
    @IBOutlet weak var noteTitleText: UITextField!
    @IBOutlet weak var languagePickerView: UIPickerView!
    
    // images outlets
    @IBOutlet weak var noteImageViewOne: UIButton!
    @IBOutlet weak var noteImageViewTwo: UIButton!
    @IBOutlet weak var noteImageViewThree: UIButton!
    @IBOutlet weak var noteImageViewFour: UIButton!
    @IBOutlet weak var noteImageViewFive: UIButton!
    
    // note text
    @IBOutlet weak var noteText: UITextView!
    
    // loaded languages
    fileprivate var languages : [ProgrammingLanguage] = []
    
    // selected language
    var selectedLanguage : ProgrammingLanguage?
    
    // selected note
    var noteForEdit : ShortNote?
    
    // edit flag
    var isEdit : Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        loadLanguages()
        languagePickerView.reloadAllComponents()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadLanguages()
        languagePickerView.reloadAllComponents()
        if let selectedProgrammingLanguage = selectedLanguage {
            let languageNameIndex = languages.flatMap{$0.name}.index(of: selectedProgrammingLanguage.name!)
            if let index = languageNameIndex {
                languagePickerView.selectRow(index, inComponent: 0, animated: true)
            }
        }
        
        if let note = noteForEdit {
            noteTitleText.text = note.title
            noteText.text = note.note
            
            // TODO : set imagse
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // add image action
    @IBAction func addImage(_ sender: UIButton) {
        // TODO : implement image picker
    }
    
    // save action
    @IBAction func saveNote(_ sender: UIButton) {
        // 1
        var result = FormValidator.isEmptyField(noteTitleText.text, withName: "Title")
        triggerValidationAlert(view: result.status, message: result.message)
        
        // 2
        if !result.status {
            result = FormValidator.isEmptyField(noteText.text, withName: "Note")
            triggerValidationAlert(view: result.status, message: result.message)
        }
        
        if !result.status {
            do {
                
                var newNote = ShortNote(context: managedContext)
                
                if let note = noteForEdit {
                    newNote = note
                }
                
                newNote.title = noteTitleText.text!
                newNote.note = noteText.text
                newNote.date = Date() as NSDate
                
                if let selectedProgrammingLanguage = selectedLanguage {
                    newNote.language = selectedProgrammingLanguage
                } else {
                    newNote.language = languages[0]
                }
                
                try managedContext.save()
            } catch let error as NSError {
                print("Unresolved error \(error), \(error.userInfo)")
            }
            
            // if edit action navigate to back using segue
            if isEdit {
                _ = navigationController?.popViewController(animated: true)
            } else {
                tabBarController?.selectedIndex = 0
            }
            
            // clear text fields
            noteTitleText.text = ""
            noteText.text = ""
        }
    }
    
    // cancel action
    @IBAction func cancel(_ sender: UIButton) {
        if isEdit {
            _ = navigationController?.popViewController(animated: true)
        } else {
            tabBarController?.selectedIndex = 0
        }
    }
    
    // hide keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        noteTitleText.endEditing(true)
        noteText.endEditing(true)
    }
    
    // hide keyboard when press on return
    @IBAction func textFieldReturn(_ sender: AnyObject) {
        _ = sender.resignFirstResponder()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SaveNoteViewController : UIPickerViewDelegate , UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return languages.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return languages[row].name!
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedLanguage = languages[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let attributedString = NSAttributedString(string: languages[row].name!, attributes: [NSForegroundColorAttributeName : StandardColors.BLUE])
        return attributedString
    }
}

// database operations
extension SaveNoteViewController {
    
    // load languages
    fileprivate func loadLanguages() {
        let fetch : NSFetchRequest<ProgrammingLanguage> = ProgrammingLanguage.fetchRequest()
        
        do {
            let results = try managedContext.fetch(fetch)
            if results.count > 0 {
                languages = results
            }
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }

}
















