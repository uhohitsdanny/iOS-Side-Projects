//
//  PlayerCell.swift
//  SpyMe
//
//  Created by Danny Navarro on 8/6/18.
//  Copyright © 2018 Danny Navarro. All rights reserved.
//

import Foundation

class PlayerCell : UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var point1: UIView!
    @IBOutlet weak var point2: UIView!
    
    var isVoted: Bool = false
}
