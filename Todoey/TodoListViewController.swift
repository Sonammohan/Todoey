//
//  ViewController.swift
//  Todoey
//
//  Created by Sona Mohan on 2018-11-14.
//  Copyright © 2018 Sona Mohan. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = ["Buy Groceries", "Pay Electricity Bills", "Pick Kids"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    // Mark - TableView DataSource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    
    
    //Mark - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         //print(itemArray[indexPath.row])
        
        if (tableView.cellForRow(at: indexPath)? .accessoryType == .checkmark)
        {
            tableView.cellForRow(at: indexPath)? .accessoryType = .none
        }
        else{
            tableView.cellForRow(at: indexPath)? .accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // Mark - Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new Todoey item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default){(action) in
            //what will happen once the user clicks the Add item button on our UIAlert
            self.itemArray.append(textField.text!)
            self.tableView.reloadData()
        }
        alert.addTextField{ (alertTextfield) in
            alertTextfield.placeholder = "Create new item"
            textField = alertTextfield
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
    
}

