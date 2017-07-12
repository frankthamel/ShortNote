//
//  SaveNoteViewController.swift
//  Short Note
//
//  Created by frank thamel on 7/12/17.
//  Copyright © 2017 Crowderia. All rights reserved.
//

import UIKit

class SaveNoteViewController: UIViewController {
    
    // connecting outlets
    @IBOutlet weak var noteTitleText: UITextField!
    @IBOutlet weak var programmingLanguageText: UITextField!
    
    // images outlets
    @IBOutlet weak var noteImageViewOne: UIButton!
    @IBOutlet weak var noteImageViewTwo: UIButton!
    @IBOutlet weak var noteImageViewThree: UIButton!
    @IBOutlet weak var noteImageViewFour: UIButton!
    @IBOutlet weak var noteImageViewFive: UIButton!
    
    // note text
    @IBOutlet weak var noteText: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // add image action
    @IBAction func addImage(_ sender: UIButton) {
    }
    
    
    // save action
    @IBAction func saveNote(_ sender: UIButton) {
    }
    
    // cancel action
    @IBAction func cancel(_ sender: UIButton) {
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
