//
//  ViewController.swift
//  SpyMe
//
//  Created by Danny Navarro on 5/1/18.
//  Copyright © 2018 Danny Navarro. All rights reserved.
//

import UIKit



class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        log("HomeViewController")
    }
    
    
    fileprivate func showGameQueueView() {
        if !self.isViewLoaded {
            return
        }
        
        let vc = UIStoryboard.loadStartingVC()
        self.addChildViewController(vc)
        self.view.addSubview(vc.view)
        self.didMove(toParentViewController: self)
    }
    
    @IBAction func beginEspionage() {
        showGameQueueView()
    }
}
