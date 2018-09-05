//
//  BusyScreen.swift
//  SpyMe
//
//  Created by Danny Navarro on 9/4/18.
//  Copyright © 2018 Danny Navarro. All rights reserved.
//

import Foundation

enum DataStatus {
    case done
    case fetching
}

class BusyScreen:UIView
{
    var isBusyViewOn:Bool = false
    
    func show(pView:UIView,cb:@escaping (_ sts:DataStatus,_ view:BusyScreen?) -> Void  )
    {
        self.isBusyViewOn = true
        let nib = UINib(nibName: "BusyScreen", bundle: Bundle.main)
        let busyScreen = nib.instantiate(withOwner: nil, options: nil)[0] as! BusyScreen
        
        busyScreen.frame = pView.bounds
        busyScreen.alpha = 0.0
        pView.addSubview(busyScreen)
        
        UIView.animate(withDuration: 0.5, animations: {busyScreen.alpha = 1.0 }, completion: { (done) in
                DispatchQueue.main.async
                {
                        cb(.done,busyScreen)
                }
        })
    }
    
    func remove(busyView:BusyScreen , cb: @escaping (_ sts:DataStatus) -> Void )
    {
        UIView.animate(withDuration: 0.5, animations: {busyView.alpha = 0.0 }, completion:
            { (done)->Void in
                DispatchQueue.main.async
                {
                        busyView.removeFromSuperview()
                        cb(.done)
                        self.isBusyViewOn = false
                }
        })
    }
}
