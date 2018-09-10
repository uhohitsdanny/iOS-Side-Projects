//
//  AppDelegate.swift
//  SpyMe
//
//  Created by Danny Navarro on 5/1/18.
//  Copyright © 2018 Danny Navarro. All rights reserved.
//

import UIKit
import Parse
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var roomId: String?
    var roomExists: Bool?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Configure Parse
        let configuration = ParseClientConfiguration {
            $0.applicationId = "spyme1029384756"
            $0.clientKey = "sdp12#djfkd@0101!"
            $0.server = "https://spy-me.herokuapp.com/parse"
        }
        Parse.initialize(with: configuration)

        roomId = UserDefaults.standard.string(forKey: "roomid")
        roomExists = UserDefaults.standard.bool(forKey: "roomExists")
        
        if roomExists!
        {
            deleteRoom()
        }
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
        
        // Clean the room from the database if you are the host
    }
    
    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "SpyMe")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func deleteRoom()
    {
        // The logic is that if the room is created, that means you are the host,
        // so the host will be the only person that has assigned a value to the variable 'room'
        // All other users will be segueing to another view controller where their app delegates
        // will contain nil for the variable 'room'
        
        if self.roomId != nil
        {
            //PFCloud.callFunction(inBackground: "deleteRoom", withParameters: ["roomid" : roomid as Any])
            let query = PFQuery(className: "Room")
            query.whereKey("roomid", equalTo: (self.roomId)!)
            query.findObjectsInBackground { (objects, error) in
                if error == nil
                {
                    if !(objects?.isEmpty)!
                    {
                        log("Parse query was successful")
                        log("Attempting to delete object")
                        let objToDelete = objects![0]
                        objToDelete.deleteInBackground(block: { (success, error) in
                            if error == nil
                            {
                                if success
                                {
                                    //         Clear User Defaults
                                    UserDefaults.standard.removeObject(forKey: "roomid")
                                    UserDefaults.standard.removeObject(forKey: "roomExists")
                                    log("Deleted object successfully and cleared User Defaults")
                                }
                                else
                                {
                                    log("Deleted object unsuccessfully")
                                }
                            }
                            else
                            {
                                log("Deleted object unsuccessfully")
                            }
                        })
                    }
                    else
                    {
                        log("Queried objects is empty.  Room might have been deleted already. (Deleted after 60 minutes)")
                        log("----------------------------")
                        print(error ?? "")
                        
                    }
                }
                else
                {
                    log("Querying Room objects failed")
                    log("----------------------------")
                    print(error ?? "")
                    
                }
            }
        }
    }
}

