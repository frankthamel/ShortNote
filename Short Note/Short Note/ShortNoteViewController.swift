//
//  ShortNoteViewController.swift
//  Short Note
//
//  Created by frank thamel on 7/12/17.
//  Copyright © 2017 Crowderia. All rights reserved.
//

import UIKit
import CoreData

class ShortNoteViewController: UIViewController {
    
    // managed object context
    var managedContext : NSManagedObjectContext!
    
    // connecting outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    
    // connecting image buttons
    @IBOutlet weak var imageOneButton: UIButton!
    @IBOutlet weak var imageTwoButton: UIButton!
    @IBOutlet weak var imageThreeButton: UIButton!
    @IBOutlet weak var imageFourButton: UIButton!
    @IBOutlet weak var imageFiveButton: UIButton!
    
    // note text
    @IBOutlet weak var noteTextView: UITextView!
    
    // current note
    var note : ShortNote?

    // preview image segue
    private let imagePreviewSegue : String = "imagePreviewSegue"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func previewImage(_ sender: UIButton) {
        performSegue(withIdentifier: imagePreviewSegue, sender: sender.tag)
    }
    
    private func setData() {
        if let currentNote = note {
            titleLabel.text = currentNote.title!
            languageLabel.text = currentNote.language!.name!
            noteTextView.text = currentNote.note!
            
            if let _ = currentNote.imageOne {
                imageOneButton.setImage(UIImage(named: "addImageIcon_active"), for: .normal)
            }
            if let _ = currentNote.imageTwo {
                imageTwoButton.setImage(UIImage(named: "addImageIcon_active"), for: .normal)
            }
            if let _ = currentNote.imageThree {
                imageThreeButton.setImage(UIImage(named: "addImageIcon_active"), for: .normal)
            }
            if let _ = currentNote.imageFour{
                imageFourButton.setImage(UIImage(named: "addImageIcon_active"), for: .normal)
            }
            if let _ = currentNote.imageFive{
                imageFiveButton.setImage(UIImage(named: "addImageIcon_active"), for: .normal)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == imagePreviewSegue {
            let destinationController = segue.destination as! ImagePreviewViewController
        
            let buttonIndex = sender as! Int
            switch buttonIndex {
            case 1:
                if let image1 = note?.imageOne {
                    destinationController.image = UIImage(data: image1 as Data)
                }
            case 2:
                if let image2 = note?.imageTwo{
                    destinationController.image = UIImage(data: image2 as Data)
                }
            case 3:
                if let image3 = note?.imageThree{
                    destinationController.image = UIImage(data: image3 as Data)
                }
            case 4:
                if let image4 = note?.imageFour {
                    destinationController.image = UIImage(data: image4 as Data)
                }
            case 5:
                if let image5 = note?.imageFive {
                    destinationController.image = UIImage(data: image5 as Data)
                }
            default:
                break
            }
        }
    }
}
