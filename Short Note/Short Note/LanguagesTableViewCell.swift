//
//  LanguagesTableViewCell.swift
//  Short Note
//
//  Created by frank thamel on 7/12/17.
//  Copyright © 2017 Crowderia. All rights reserved.
//

import UIKit

class LanguagesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var languageNameFirstLetterLabel: UILabel!
    @IBOutlet weak var languageNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
