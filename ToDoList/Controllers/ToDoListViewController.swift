//
//  ViewController.swift
//  ToDoList
//
//  Created by Ginny Wan on 23/07/2019.
//  Copyright © 2019 Ginny Wan. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    var itemArray = [Item]()

    //add defaults to make sure that itemArray and items added to the item Array would be stored
    let defaults = UserDefaults.standard
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        print(dataFilePath)

        loadItems()
        
        //ensure that defaults are saved even when teh app accidentally recedes to the background or terminates 
//        if let items = defaults.array(forKey: "ToDoListArray" ) as? [Item] {
//            itemArray = items
//        }
    }
    
    //MARK - Tableview Datasource Methods: set up the table framework
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done == true ? .checkmark : .none
        
        return cell
    }
    
    
    //MARK - Add New Items Button
    @IBAction func AddNewItems(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        //UI of the Alert Screen (the part that doesn't involve action?)
        let alert = UIAlertController(title: "What would you like to add to your to-do list?", message: "", preferredStyle: .alert)
        
        //What happens when the user clicks the Alert/ Add item button
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            
            let newItem = Item()
            
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            
//            //messages saved to defaults in plist (always have keys and values)
//            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            
            self.saveItems()
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
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        //save this boolean info to the info.plist
        saveItems()
        
        //make the grey area underneath selected row fade away afrer selection
        tableView.deselectRow(at: indexPath, animated: true)
        
        //checkmark next to the cell selected
//        if  tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        } else {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }
//        
    }
    
    
    func saveItems() {
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
            
        } catch {
            print("Error encoding item array, \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadItems() {
    
        if let data = try? Data(contentsOf: dataFilePath!) {
        
            let decoder = PropertyListDecoder()
            
            do {
                itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("Error decoding item array, \(error).")
            }
        }
        
    }

}

