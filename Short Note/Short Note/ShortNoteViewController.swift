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

    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func previewImage(_ sender: UIButton) {
    }
    
    private func setData() {
        if let currentNote = note {
            titleLabel.text = currentNote.title!
            languageLabel.text = currentNote.language!.name!
            noteTextView.text = currentNote.note!
            
            // TODO : Set images for priview
        }
    }
}
