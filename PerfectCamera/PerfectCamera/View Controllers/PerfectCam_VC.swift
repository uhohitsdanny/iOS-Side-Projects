//
//  Main_VC.swift
//  PerfectCamera
//
//  Created by Danny Navarro on 1/18/19.
//  Copyright © 2019 Squirrel. All rights reserved.
//

import UIKit

class PerfectCam_VC: UIViewController {

    @IBOutlet weak var btnView : UIView!
    @IBOutlet weak var camBtn : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setup()
    }

}

extension PerfectCam_VC
{
    func setup()
    {
        setupUI()
        buttonSetup()
    }
    
    func setupUI()
    {
        camBtn.layer.cornerRadius = camBtn.frame.width / 2
        btnView.layer.cornerRadius = btnView.frame.width / 2
    }
    
    func buttonSetup()
    {
        let tapGest = UITapGestureRecognizer(target: self, action: #selector(takePic))
        let longPressGest = UILongPressGestureRecognizer(target: self, action: #selector(recordVideo))
        tapGest.numberOfTapsRequired = 1
        self.camBtn.addGestureRecognizer(tapGest)
        self.camBtn.addGestureRecognizer(longPressGest)
    }
    
    @objc func takePic()
    {
        print("Action: taking picture")
    }
    
    @objc func recordVideo()
    {
        print("Action: recording video")
    }
}
