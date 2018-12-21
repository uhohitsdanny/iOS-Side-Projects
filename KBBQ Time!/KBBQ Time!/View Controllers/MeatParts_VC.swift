//
//  MeatParts_VC.swift
//  KBBQ Time!
//
//  Created by Danny Navarro on 12/17/18.
//  Copyright © 2018 Squirrel. All rights reserved.
//

import UIKit

class MeatParts_VC: UIViewController {

    // local interface variables
    @IBOutlet weak var meat_imageview : UIImageView!
    @IBOutlet weak var meat_collectionview: UICollectionView!
    
    var meatType : MeatType!
    var meat_parts : [MeatPartType] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Double check if meat type is defined
        if meatType != nil
        {
            mInit()
            mSetup()
        }
    }
}


extension MeatParts_VC
{
    func mInit()
    {
        meat_parts = []
    }
    
    func mSetup()
    {
        // TODO: Setup image depending on what meat is chosen and the collectionview cells
        switch meatType
        {
        case .beef?:
            self.meat_imageview.image = UIImage(named: "pig.jpg")
            MeatParts.beef.allCases.forEach { (part) in
                meat_parts.append(part)
            }
            break
            
        case  .pork?:
            self.meat_imageview.image = UIImage(named: "pig.jpg")
            MeatParts.pork.allCases.forEach { (part) in
                meat_parts.append(part)
            }
            
            break
            
        case .some(.chicken):
            self.meat_imageview.image = UIImage(named: "pig.jpg")
            MeatParts.chicken.allCases.forEach { (part) in
                meat_parts.append(part)
            }
            break
            
        case .some(.seafood):
            self.meat_imageview.image = UIImage(named: "pig.jpg")
            MeatParts.seafood.allCases.forEach { (part) in
                meat_parts.append(part)
            }
            break
            
        default:
            self.meat_imageview.image = UIImage(named: "pig.jpg")
        }
        
        // The custom code is in the extension in UIImageView+Custom file.
        // viewDidLayoutSubviews is overwritten in the extension.
        // This changes the corner radius depending on the aspect ratio
        // of the image, normally it is not possible.
        let cradius = self.meat_imageview.frame.size.height / 2.0
        self.meat_imageview.cornerRadius = cradius
    }
    
}

extension MeatParts_VC
{
    @IBAction func closeModule(_ sender:Any)
    {
        self.dismiss(animated: true, completion: nil)
    }
}

extension MeatParts_VC : UICollectionViewDelegate, UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.meat_parts.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MeatPart", for: indexPath) as! MeatCell
        cell.meat_label.text = meat_parts[indexPath.row].rawValue
        
        return cell
    }
    
    // TODO: Setup next view controller's data and present
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "MeatTimer") as! MeatTimer_VC
        vc.meatpart = meat_parts[indexPath.row]
        self.present(vc, animated: true, completion: nil)
    }
}

