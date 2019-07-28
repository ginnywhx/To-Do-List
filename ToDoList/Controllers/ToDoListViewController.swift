//
//  ViewController.swift
//  ToDoList
//
//  Created by Ginny Wan on 23/07/2019.
//  Copyright © 2019 Ginny Wan. All rights reserved.
//

import UIKit
import CoreData

class ToDoListViewController: UITableViewController {

    var itemArray = [Item]()

    var selectedCategory : Category? {
        
        didSet {
            loadItems()
        }
        
    }
    //MARK: add defaults to make sure that itemArray and items added to the item Array would be stored
    let defaults = UserDefaults.standard
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        loadItems()
        
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    //MARK: Tableview Datasource Methods: set up the table framework
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
    
    
    //MARK: Add New Items Button
    @IBAction func AddNewItems(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        //UI of the Alert Screen (the part that doesn't involve action?)
        let alert = UIAlertController(title: "What would you like to add to your to-do list?", message: "", preferredStyle: .alert)
        
        //What happens when the user clicks the Alert/ Add item button
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            let newItem = Item(context: self.context)
            
            newItem.title = textField.text!
            newItem.done = false
            newItem.parentCategory = self.selectedCategory
            
            self.itemArray.append(newItem)
            
//messages saved to defaults in plist (always have keys and values)
//self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            
            self.saveItems()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
            
        }
        
        alert.addAction(action)
        
        present(alert,animated: true, completion: nil)
    }
    
    
    
    //MARK: Tableview Data Delegate Methods: what to do with the table rows and columns once selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //shows which row I have selected
        
        //MARK: delete data?
        
        context.delete(itemArray[indexPath.row])
        itemArray.remove(at: indexPath.row)
        saveItems()
        
        //MARK: update data?
//        itemArray[indexPath.row].setValue("Completed", forKey: "title")
//
//        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
//
        //save this boolean info to the info.plist
//        saveItems()
        
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
       
        
        do {
         try context.save()
            
        } catch {
            print("Error saving context.")
        }
        
        self.tableView.reloadData()
    }

    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest(), predicate: NSPredicate? = nil) {

        
        //filter results that only have parent Category of X,Y,Z
        let cateogoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
        
        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [cateogoryPredicate, predicate!])
        
        request.predicate = compoundPredicate
        
        do {
            itemArray = try context.fetch(request)
        } catch {
            print("Error fetching data - \(error)")
        }
        tableView.reloadData()
    }

}

//MARKL: Search Bar delegate
extension ToDoListViewController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        
        //how we would like to structure the query
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        
        //how  we would like to sort the data we get back from the query
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        loadItems(with: request, predicate: predicate)
    
    }
    
    
    // only triggered when the text has changed
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text?.count == 0 {
            
            loadItems()
            
            //dismiss the keyboard
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
    
        }
    }
}
    

