//
//  Data.swift
//  ToDoList
//
//  Created by Ginny Wan on 30/07/2019.
//  Copyright © 2019 Ginny Wan. All rights reserved.
//

import Foundation
import RealmSwift

class Data: Object {
    //if the user changes the name of X during the use of the app, Realm can update those changes in names dynamically
    //dynamic is an objective C value
    @objc dynamic var name: String = ""
    @objc dynamic var ethnicity: String = ""
    @objc dynamic var age: Int = 0
    
}
