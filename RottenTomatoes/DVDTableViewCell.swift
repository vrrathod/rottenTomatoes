//
//  DVDTableViewCell.swift
//  RottenTomatoes
//
//  Created by vr on 9/13/14.
//  Copyright (c) 2014 vr. All rights reserved.
//

import UIKit

class DVDTableViewCell: UITableViewCell {

    @IBOutlet weak var movieName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

////////////////////////////////////////////////////////////////////////
    func setMovieName(name: NSString) {
        movieName.text = name;
    }

}
