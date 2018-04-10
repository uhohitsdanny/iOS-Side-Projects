//
//  DisplayDecision_VC.swift
//  Easy Decision
//
//  Created by Danny Navarro on 4/9/18.
//

import UIKit

class DisplayDecision_VC: UIViewController {

    @IBOutlet weak var decisionTitle:UILabel?
    @IBOutlet weak var imgView:UIImageView?
    
    var googleImg:GoogleImage?
    
    override func viewWillAppear(_ animated: Bool) {
        moduleInit()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func moduleInit() {
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
                        let image = UIImage(data: validData)
                        self.imgView?.image = image
                        group.leave()
                    })
                }
                group.wait()
            }
        }
        else {
            
        }
    }
}


