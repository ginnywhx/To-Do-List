//
//  item.swift
//  ToDoList
//
//  Created by Ginny Wan on 24/07/2019.
//  Copyright © 2019 Ginny Wan. All rights reserved.
//

import Foundation

class Item: Encodable, Decodable {
    var title: String = " "
    var done: Bool = false
    
}
