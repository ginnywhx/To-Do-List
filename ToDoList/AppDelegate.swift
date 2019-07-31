//
//  AppDelegate.swift
//  ToDoList
//
//  Created by Ginny Wan on 23/07/2019.
//  Copyright © 2019 Ginny Wan. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    // happens before view did load
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
       
        let config = Realm.Configuration(
            schemaVersion: 1,
            migrationBlock: { migration, oldSchemaVersion in
                
                if (oldSchemaVersion < 1) {
                    // Nothing to do!
                    
                }
        })
        Realm.Configuration.defaultConfiguration = config
        
        //        let configCheck = Realm.Configuration();
        //        let configCheck2 = Realm.Configuration.defaultConfiguration;
        //        let schemaVersion = configCheck.schemaVersion
        //        print("Schema version \(schemaVersion) and configCheck2 \(configCheck2.schemaVersion)")
        
        let configCheck = Realm.Configuration();
        
        do {
            let fileUrlIs = try schemaVersionAtURL(configCheck.fileURL!)
            print("schema version \(fileUrlIs)")
        } catch  {
            print(error)
        }

        print(Realm.Configuration.defaultConfiguration.fileURL!)

//        do {
//            _ = try Realm()
//        } catch {
//            print("Error initialising new realm, \(error)")
//        }
//

        return true
       
    }

}

