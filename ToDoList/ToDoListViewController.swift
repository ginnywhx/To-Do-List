//
//  ViewController.swift
//  ToDoList
//
//  Created by Ginny Wan on 23/07/2019.
//  Copyright © 2019 Ginny Wan. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    var itemArray = ["Finish an Ios App", "LBS Coursework", "Read Entrepreneurship-related Books"]

    
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
    
    
    //MARK - Add New Items Button
    @IBAction func AddNewItems(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        //UI of the Alert Screen (the part that doesn't involve action?)
        let alert = UIAlertController(title: "What would you like to add to your to-do list?", message: "", preferredStyle: .alert)
        
        //What happens when the user clicks the Alert/ Add item button
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            self.itemArray.append(textField.text!)
            
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
            
        }
        
        alert.addAction(action)
        
        present(alert,animated: true, completion: nil)
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

