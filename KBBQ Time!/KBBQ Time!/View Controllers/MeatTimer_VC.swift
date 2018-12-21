//
//  MeatTimer_VC.swift
//  KBBQ Time!
//
//  Created by Danny Navarro on 12/18/18.
//  Copyright © 2018 Squirrel. All rights reserved.
//

import UIKit

class MeatTimer_VC: UIViewController {

    // local interface variables
    @IBOutlet weak var meatpart_label : UILabel!
    var meatpart : MeatPartType?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mSetup()
    }
}

extension MeatTimer_VC
{
    func mSetup()
    {
        self.meatpart_label.text = self.meatpart?.rawValue
    }
}

extension MeatTimer_VC
{
    @IBAction func closeModule(_ sender:Any)
    {
        self.dismiss(animated: true, completion: nil)
    }
}
