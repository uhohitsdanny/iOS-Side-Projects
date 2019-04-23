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
    
    override func becomeFirstResponder() -> Bool {
        return true
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake
        {
            let alertVC = UIAlertController(title: "", message: "Reshuffle numbers?", preferredStyle: .alert)
            let titleFont:[NSAttributedString.Key : AnyObject] = [ NSAttributedString.Key.font : UIFont(name: "AmericanTypewriter", size: 18)! ]
            let messageFont:[NSAttributedString.Key : AnyObject] = [ NSAttributedString.Key.font : UIFont(name: "HelveticaNeue-Thin", size: 14)! ]
            let attributedTitle = NSMutableAttributedString(string: "Lotto ", attributes: titleFont)
            let attributedMessage = NSMutableAttributedString(string: "Reshuffle the lotto numbers?", attributes: messageFont)
            alertVC.setValue(attributedTitle, forKey: "attributedTitle")
            alertVC.setValue(attributedMessage, forKey: "attributedMessage")
            
            alertVC.view.tintColor = UIColor(red: 180/255, green: 158/255, blue: 101/255, alpha: 1.0)
            alertVC.view.layer.cornerRadius = 25
            
            alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                self.numberGen?.generate()
                self.numberslist.reloadData()
            }))
            alertVC.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            self.present(alertVC, animated: true, completion: nil)
        }
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let pt = collectionView.frame.size.width / 7.5
        
        return CGSize(width: pt, height: pt)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Number Cell", for: indexPath) as! NumberCell
        
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

