//
//  WalkthroughContentViewController.swift
//  Short Note
//
//  Created by frank thamel on 7/14/17.
//  Copyright © 2017 Crowderia. All rights reserved.
//

import UIKit

class WalkthroughContentViewController: UIViewController {
    
    // connecting outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var appNameImageView: UIImageView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var forwardButton: UIButton!
    
    var index = 0
    var imageFile = ""
    var content = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = UIImage(named: imageFile)
        contentLabel.text = content
        pageControl.currentPage = index
        
        // set button title
        switch index {
        case 0...1:
            forwardButton.setTitle("NEXT", for: .normal)
        case 2:
            forwardButton.setTitle("DONE", for: .normal)
        default:
            break
        }
    }

    @IBAction func nextButtonTapped(_ sender: UIButton) {
        switch index {
        case 0...1:
            let pageViewController = parent as! WalkthroughPageViewController
            pageViewController.forward(index: index)
        case 2 :
            UserDefaults.standard.set(true, forKey: "viewedWalkthrough")
            dismiss(animated: true, completion: nil)
        default:
            break
        }
    }
}
