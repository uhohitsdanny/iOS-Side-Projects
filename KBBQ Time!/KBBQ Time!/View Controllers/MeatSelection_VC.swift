//
//  MeatSelection_VC.swift
//  KBBQ Time!
//
//  Created by Danny Navarro on 12/15/18.
//  Copyright © 2018 Squirrel. All rights reserved.
//

import UIKit

class MeatSelection_VC: UIViewController {

    // local interface variables
    @IBOutlet weak var beef_btn : UIButton!
    @IBOutlet weak var pork_btn : UIButton!
    @IBOutlet weak var chkn_btn : UIButton!
    @IBOutlet weak var seafood_btn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension MeatSelection_VC
{
    @IBAction func segueToMeatType(_ sender:AnyObject)
    {
        let vc = UIStoryboard.init(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "MeatParts") as! MeatParts_VC
        
        switch sender.tag {
        case 0:
            vc.meatType = .beef
            break
        case 1:
            vc.meatType = .pork
            break
        case 2:
            vc.meatType = .chicken
            break
        case 3:
            vc.meatType = .seafood
            break
        default:
            vc.meatType = nil
        }
        
        // Present next view controller only if the meat type is defined
        if vc.meatType != nil
        {
            self.present(vc, animated: true, completion: nil)
        }
    }
}
