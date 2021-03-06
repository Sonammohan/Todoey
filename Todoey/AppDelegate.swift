//
//  AppDelegate.swift
//  Todoey
//
//  Created by Sona Mohan on 2018-11-14.
//  Copyright © 2018 Sona Mohan. All rights reserved.
//

import UIKit
//import CoreData
import RealmSwift


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //print(Realm.Configuration.defaultConfiguration.fileURL)
        
        
        do{
            _ = try Realm()
            
            }
        
        catch{
            print("Error initialising new realm, \(error)")
        }
    
        return true
    }

//func applicationWillTerminate(_ application: UIApplication) {
//    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
//    // Saves changes in the application's managed object context before the application terminates.
//    self.saveContext()
//}

    
// MARK: - Core Data stack

//lazy var persistentContainer: NSPersistentContainer = {
//    /*
//     The persistent container for the application. This implementation
//     creates and returns a container, having loaded the store for the
//     application to it. This property is optional since there are legitimate
//     error conditions that could cause the creation of the store to fail.
//     */
//    let container = NSPersistentContainer(name: "DataModel")
//    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
//        if let error = error as NSError? {
//            
//            fatalError("Unresolved error \(error), \(error.userInfo)")
//        }
//    })
//    return container
//}()
//
//// MARK: - Core Data Saving support
//
//func saveContext () {
//    let context = persistentContainer.viewContext
//    if context.hasChanges {
//        do {
//            try context.save()
//        } catch {
//            // Replace this implementation with code to handle the error appropriately.
//            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//            let nserror = error as NSError
//            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//        }
//    }
//}
//
}

