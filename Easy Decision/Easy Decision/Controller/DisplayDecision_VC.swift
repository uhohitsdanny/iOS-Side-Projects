//
//  DisplayDecision_VC.swift
//  Easy Decision
//
//  Created by Danny Navarro on 4/9/18.
//

import UIKit

class DisplayDecision_VC: UIViewController {

    @IBOutlet weak var decisionTitleLabel:UILabel?
    @IBOutlet weak var imgView:UIImageView?
    
    var decisionTitle:String?
    var googleImg:GoogleImage?
    
    override func viewWillAppear(_ animated: Bool) {
        moduleInit()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func moduleInit() {
        var image:UIImage?
        if googleImg != nil {
            //Check if items is nil
            if googleImg?.items != nil {
                //Create URL Session Data Task and retrieve the image data
                //with provided image link from Decisions_VC.
                let group = DispatchGroup()
                group.enter()
                
                let imgUrl = URL(string: (googleImg?.items![0].link)!)
                DispatchQueue.global().async {
                    GoogleImage.retrieveImage(with: imgUrl!, completion: { (validData) in
                        image = UIImage(data: validData)
                        group.leave()
                    })
                }
                group.wait()
                self.decisionTitleLabel?.text = decisionTitle
                self.imgView?.image = image
                self.imgView?.contentMode = .scaleAspectFit
            }
        }
        else {
            
        }
    }
}


