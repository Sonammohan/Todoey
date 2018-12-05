//
//  ViewController.swift
//  Todoey
//
//  Created by Sona Mohan on 2018-11-14.
//  Copyright © 2018 Sona Mohan. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    
    var itemArray = [Item]()
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask) .first?.appendingPathComponent("Items.plist")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print(dataFilePath)
        
        loadItems()
        
        
        // Do any additional setup after loading the view, typically from a nib.
       // if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
       //  itemArray = items
       
        //}
    }
    

    // Mark - TableView DataSource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
       
        // Ternary operator
        //value = condition? valueIfTrue : valueIfFalse
        
        cell.accessoryType = item.done ? .checkmark : .none
        
//        if itemArray[indexPath.row].done == true{
//            cell.accessoryType = .checkmark
//        }
//        else {
//            cell.accessoryType = .none
//        }
        return cell
    }
    
    
    //Mark - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         //print(itemArray[indexPath.row])
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        saveItems()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // Mark - Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new Todoey item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default){(action) in
            //what will happen once the user clicks the Add item button on our UIAlert
            
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            
            self.saveItems()
            
            
            
        }
        alert.addTextField{ (alertTextfield) in
            alertTextfield.placeholder = "Create new item"
            textField = alertTextfield
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
     func saveItems()
     {
        
        let encoder = PropertyListEncoder()
        do{
            let data =  try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        }
        catch{
            print("Error encoding itemArray, \(error)")
        }
        
        tableView.reloadData()
    }
    func loadItems()
    {
        if let data = try? Data(contentsOf: dataFilePath!){
        
           let decoder = PropertyListDecoder()
        do{
            
            itemArray = try decoder.decode([Item].self, from: data)
        }
        catch{
            print("Error decoding itemArray, \(error)")
        }
        
    }
    
}
}