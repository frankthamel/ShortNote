//
//  LogInViewController.swift
//  Short Note
//
//  Created by frank thamel on 7/11/17.
//  Copyright © 2017 Crowderia. All rights reserved.
//

import UIKit
import CryptoSwift

class LogInViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let encryptedString = "Frank".md5()
        print(encryptedString)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
