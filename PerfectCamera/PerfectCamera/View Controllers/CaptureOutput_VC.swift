//
//  CaptureOutput_VC.swift
//  PerfectCamera
//
//  Created by Danny Navarro on 4/17/19.
//  Copyright © 2019 Squirrel. All rights reserved.
//

import UIKit
import AVFoundation

class CaptureOutput_VC : UIViewController
{
    @IBOutlet weak var imageView : UIImageView!
    
    var stillImageOut : AVCapturePhotoOutput!
    var videoPreviewLayer : AVCaptureVideoPreviewLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
}

extension CaptureOutput_VC
{
    func setImageView(with image:UIImage)
    {
        self.imageView.image = image
    }
    
    @IBAction func dismissVC()
    {
        self.dismiss(animated: true, completion: nil)
    }
}
