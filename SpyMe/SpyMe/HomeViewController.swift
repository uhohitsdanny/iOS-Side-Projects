//
//  ViewController.swift
//  SpyMe
//
//  Created by Danny Navarro on 5/1/18.
//  Copyright © 2018 Danny Navarro. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        log("HomeViewController")
        //One time testing. Delete after DB is setup******
//        let room = PFObject(className: "Room")
//        room["roomid"] = "testid"
//        room["pw"] = "testpw"
//        room["status"] = "standby"
//
//        room.saveInBackground { (success, error) in
//            if success{
//                log("Parse successfully save the room data")
//            }
//            else{
//                log(error ?? "Error: Parse could not save the room data" as! Error)
//            }
//        }
        
        let query = PFQuery(className: "Room")
        query.whereKey("roomid", equalTo: "testid")
        query.findObjectsInBackground { (objects, error) in
            if error == nil {
                let roomid = objects![0].object(forKey: "roomid") as! String
                log("Parse query was successful")
                log("Found room ID " + roomid)
            }
            else {
                log("Querying Room objects failed")
                log("----------------------------")
                print(error ?? "")
            }
        }
    }
    
}
