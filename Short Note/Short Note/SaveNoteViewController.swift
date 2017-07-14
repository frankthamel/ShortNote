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
    
    // current button
    fileprivate var currentButtonId : Int = 1
    
    // current button
    fileprivate var currentButton : UIButton!
    
    // shot not images list
    fileprivate var image1 : UIImage?
    fileprivate var image2 : UIImage?
    fileprivate var image3 : UIImage?
    fileprivate var image4 : UIImage?
    fileprivate var image5 : UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // check current user
        validateUser(managedContext: managedContext)
        
        loadLanguages()
        languagePickerView.reloadAllComponents()
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
        } else {
            languagePickerView.selectRow(0, inComponent: 0, animated: true)
        }
        
        if let note = noteForEdit {
            noteTitleText.text = note.title
            noteText.text = note.note
            
            // set button image
            if let _ = note.imageOne {
                noteImageViewOne.setImage(UIImage(named: "addImageIcon_active"), for: .normal)
            }
            if let _ = note.imageTwo {
                noteImageViewTwo.setImage(UIImage(named: "addImageIcon_active"), for: .normal)
            }
            if let _ = note.imageThree {
                noteImageViewThree.setImage(UIImage(named: "addImageIcon_active"), for: .normal)
            }
            if let _ = note.imageFour{
                noteImageViewFour.setImage(UIImage(named: "addImageIcon_active"), for: .normal)
            }
            if let _ = note.imageFive{
                noteImageViewFive.setImage(UIImage(named: "addImageIcon_active"), for: .normal)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // add image action
    @IBAction func addImage(_ sender: UIButton) {
        
        // set currently tapped button
        switch sender.tag {
        case 1:
            setCurrentButton(noteImageViewOne, withId: 1)
        case 2:
            setCurrentButton(noteImageViewTwo, withId: 2)
        case 3:
            setCurrentButton(noteImageViewThree, withId: 3)
        case 4:
            setCurrentButton(noteImageViewFour, withId: 4)
        case 5:
            setCurrentButton(noteImageViewFive, withId: 5)
        default:
            break
        }
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
                    newNote = note // reuse the note for edit
                }
                
                newNote.title = noteTitleText.text!
                newNote.note = noteText.text
                newNote.date = Date() as NSDate
                
                if let selectedProgrammingLanguage = selectedLanguage {
                    newNote.language = selectedProgrammingLanguage
                } else {
                    newNote.language = languages[0]
                }
                
                // bind picked images to node model
                if let image1 = image1 {
                    newNote.imageOne = NSData(data : UIImageJPEGRepresentation(image1, 1.0)!)
                }
                
                if let image2 = image2 {
                    newNote.imageTwo = NSData(data : UIImageJPEGRepresentation(image2, 1.0)!)
                }
                
                if let image3 = image3 {
                    newNote.imageThree = NSData(data : UIImageJPEGRepresentation(image3, 1.0)!)
                }
                
                if let image4 = image4 {
                    newNote.imageFour = NSData(data : UIImageJPEGRepresentation(image4, 1.0)!)
                }
                
                if let image5 = image5 {
                    newNote.imageFive = NSData(data : UIImageJPEGRepresentation(image5, 1.0)!)
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
            
            // clear fields
            clearFields()
        }
    }
    
    // clear fields
    private func clearFields() {
        // change button image to inactive status
        noteImageViewOne.setImage(UIImage(named: "addImageIcon_inactive"), for: .normal)
        noteImageViewTwo.setImage(UIImage(named: "addImageIcon_inactive"), for: .normal)
        noteImageViewThree.setImage(UIImage(named: "addImageIcon_inactive"), for: .normal)
        noteImageViewFour.setImage(UIImage(named: "addImageIcon_inactive"), for: .normal)
        noteImageViewFive.setImage(UIImage(named: "addImageIcon_inactive"), for: .normal)

        selectedLanguage = nil
    }
    
    // cancel action
    @IBAction func cancel(_ sender: UIButton) {
        clearFields()
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
    
    // set current button
    private func setCurrentButton(_ button : UIButton, withId id : Int) {
        currentButtonId = id
        currentButton = button
        triggerActionSheetForImagePicker(delegate: self)
    }

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

// load button image
extension SaveNoteViewController : UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            currentButton.setImage(UIImage(named: "addImageIcon_active"), for: .normal)
            switch currentButtonId {
            case 1:
                image1 = selectedImage
            case 2:
                image2 = selectedImage
            case 3:
                image3 = selectedImage
            case 4:
                image4 = selectedImage
            case 5:
                image5 = selectedImage
            default:
                break
            }
        }
        
        dismiss(animated: true, completion: nil)
    }

}















