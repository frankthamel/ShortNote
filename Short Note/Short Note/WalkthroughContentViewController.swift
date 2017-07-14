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
    
    internal var index = 0
    internal var imageFile = ""
    internal var content = ""
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        imageView.alpha = 0
        appNameImageView.alpha = 0
        contentLabel.alpha = 0
        pageControl.alpha = 0
        forwardButton.alpha = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateContent() // start animation
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
    
    
    private func animateContent() {
        
        // animate image view
        UIView.animate(withDuration: 0.5, animations: {
            self.imageView.alpha = 1
        })
        
        // animate app name image
        UIView.animate(withDuration: 0.7, animations: {
            self.appNameImageView.alpha = 1
        })
        
        // animate content label
        UIView.animate(withDuration: 0.9, animations: {
            self.contentLabel.alpha = 1
            self.pageControl.alpha = 1
        })
        
        // animate nextButton
        UIView.animate(withDuration: 1.1, animations: {
            self.forwardButton.alpha = 1
        })
    }
}
