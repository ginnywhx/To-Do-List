//
//  ViewController.swift
//  ToDoList
//
//  Created by Ginny Wan on 23/07/2019.
//  Copyright © 2019 Ginny Wan. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    let itemArray = ["Finish an Ios App", "LBS Coursework", "Read Entrepreneurship-related Books"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //MARK - Tableview Datasource Methods: set up the table framework
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
    
    //MARK - Tableview Data Delegate Methods: what to do with the table rows and columns once selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //shows which row I have selected
//        print(itemArray[indexPath.row])
        
        //make the grey area underneath selected row fade away afrer selection
       tableView.deselectRow(at: indexPath, animated: true)
        
        //checkmark next to the cell selected
        if  tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
    }
    
    
    

}

