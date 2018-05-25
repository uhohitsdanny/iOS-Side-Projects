//
//  UIStoryboard+Loader.swift
//  SpyMe
//
//  Created by Danny Navarro on 5/7/18.
//  Copyright © 2018 Danny Navarro. All rights reserved.
//

import UIKit

fileprivate enum Storyboard : String {
    case main = "Main"
    case gameview = "GameView"
}

fileprivate extension UIStoryboard {
    
    static func loadFromMain(_ identifier: String) -> UIViewController {
        return load(from: .main, identifier: identifier)
    }

    static func load(from storyboard: Storyboard, identifier: String) -> UIViewController {
        let uiStoryboard = UIStoryboard(name: storyboard.rawValue, bundle: nil)
        return uiStoryboard.instantiateViewController(withIdentifier: identifier)
    }
}

// MARK: View Controllers

extension UIStoryboard {
    static func loadStartingVC() -> NameCreation_VC {
        return loadFromMain("NameCreation_VC") as! NameCreation_VC
    }
}
