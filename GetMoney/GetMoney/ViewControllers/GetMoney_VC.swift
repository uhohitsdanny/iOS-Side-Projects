//
//  ViewController.swift
//  GetMoney
//
//  Created by Danny Navarro on 4/13/19.
//  Copyright © 2019 Squirrel. All rights reserved.
//

import UIKit

class GetMoney_VC: UIViewController {
    
    @IBOutlet weak var numberslist : UICollectionView!
    
     var numberGen : NumberGen?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        numberGen = NumberGen()
        setup()
    }
}

extension GetMoney_VC
{
    func setup()
    {
        numberGen!.generate()
        
    }
}

extension GetMoney_VC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return numberGen!.numbers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Number Cell", for: indexPath) as! NumberCell
        
        cell.frame.size.width = collectionView.frame.width / 7
        cell.frame.size.height = collectionView.frame.width / 7
        
        print("\(cell.frame.size.width) : \(collectionView.frame.width / 7)")
        
        if(indexPath.row == 5)
        {
            cell.numberLbl.text = ""
        }
        else if(indexPath.row == 6)
        {
            let number = numberGen?.numbers[indexPath.section][indexPath.row-1]
            cell.numberLbl.text = "\(number ?? 0)"
        }
        else
        {
            let number = numberGen?.numbers[indexPath.section][indexPath.row]
            cell.numberLbl.text = "\(number ?? 0)"
        }
        
        return cell
    }
}

