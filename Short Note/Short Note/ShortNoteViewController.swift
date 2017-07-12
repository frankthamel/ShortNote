//
//  ShortNoteViewController.swift
//  Short Note
//
//  Created by frank thamel on 7/12/17.
//  Copyright © 2017 Crowderia. All rights reserved.
//

import UIKit

class ShortNoteViewController: UIViewController {
    
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
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func previewImage(_ sender: UIButton) {
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
