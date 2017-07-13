//
//  ImagePreviewViewController.swift
//  Short Note
//
//  Created by frank thamel on 7/13/17.
//  Copyright © 2017 Crowderia. All rights reserved.
//

import UIKit

class ImagePreviewViewController: UIViewController {
    
    // connecting outlets
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var previewImageView: UIImageView!
    
    // current image
    var image : UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set preview image
        backgroundImageView.image = image
        previewImageView.image = image
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
