//
//  WalkthroughPageViewController.swift
//  Short Note
//
//  Created by frank thamel on 7/14/17.
//  Copyright © 2017 Crowderia. All rights reserved.
//

import UIKit

class WalkthroughPageViewController: UIPageViewController, UIPageViewControllerDataSource {
    
    // page content
    private var pageContent : [String] = [
        "" ,
        "Test application, Test application, Test application, Test application, Test application" ,
        "Test application, Test application, Test application, Test application, Test application"]
    
    private var imageNames : [String] = ["Logo","defaultProfilePic","walkthrough_search_icon"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set data source
        dataSource = self
        
        // create first walkthrough screen
        if let startingViewController = contentViewController(at: 0) {
            setViewControllers([startingViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! WalkthroughContentViewController).index
        index -= 1
        return contentViewController(at: index)
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! WalkthroughContentViewController).index
        index += 1
        return contentViewController(at: index)
    }
    
    private func contentViewController(at index : Int) -> WalkthroughContentViewController? {
        if index < 0 || index >= pageContent.count {
            return nil
        }
        
        // get access to WalkthroughContentVieController from storyboard
        if let pageContentViewController = storyboard?.instantiateViewController(withIdentifier: "WalkthroughContentViewController") as? WalkthroughContentViewController {
            pageContentViewController.imageFile = imageNames[index]
            pageContentViewController.content = pageContent[index]
            pageContentViewController.index = index
            
            return pageContentViewController
        }
        
        return nil
    }
    
    func forward(index : Int) {
        if let nextViewController = contentViewController(at: index + 1) {
            setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)
        }
    }
}
