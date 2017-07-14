//
//  ImagePreviewViewController.swift
//  Short Note
//
//  Created by frank thamel on 7/13/17.
//  Copyright © 2017 Crowderia. All rights reserved.
//

import UIKit
import CoreData

class ImagePreviewViewController: UIViewController {
    
    // managed object context
    internal var managedContext : NSManagedObjectContext!
    
    // connecting outlets
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var previewImageView: UIImageView!
    
    // current image
    var image : UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // check current user
        validateUser(managedContext: managedContext)
        
        // set preview image
        backgroundImageView.image = image
        previewImageView.image = image
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
