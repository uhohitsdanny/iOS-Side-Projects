//
//  Helpers.swift
//  SpyMe
//
//  Created by Danny Navarro on 6/16/18.
//  Copyright © 2018 Danny Navarro. All rights reserved.
//

import UIKit

func TopController() -> UIViewController {
    var topController : UIViewController = (UIApplication.shared.keyWindow?.rootViewController)!
    
    while (topController.presentedViewController != nil) {
        topController = topController.presentedViewController!
    }
    return topController
}
