//
//  ViewController.swift
//  Todoey
//
//  Created by Sona Mohan on 2018-11-14.
//  Copyright © 2018 Sona Mohan. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController{
    
    
    var itemArray = [Item]()
    var selectedCategory : Category? {
        didSet {
            loadItems()
        }
    }
    
   
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print( FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        
        
        
        
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
        //context.delete(itemArray[indexPath.row])
        //itemArray.remove(at: indexPath.row)
        
        
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
           
            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.done  = false
            newItem.parentCategory = self.selectedCategory
            
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
        
        //let encoder = PropertyListEncoder()
        do{
            
            try context.save()
        }
        catch{
            print("Error saving context, \(error)")
        }
        
        tableView.reloadData()
    }
    func loadItems(with request:NSFetchRequest<Item> = Item.fetchRequest(), predicate : NSPredicate? = nil)
    {
        
        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
        if let additionalPredicate = predicate {
            request.predicate =  NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionalPredicate])
        }
            else {
                request.predicate = categoryPredicate
            }
    
        //let request: NSFetchRequest<Item> = Item.fetchRequest()
        do{
            itemArray = try context.fetch(request)
        }
        catch{
            print("Error fetching data from context \(error)")
        }
        tableView.reloadData()
    }
    
}

extension TodoListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        
        request.sortDescriptors = [NSSortDescriptor(key : "title", ascending : true)]
        loadItems(with: request, predicate: predicate)
        
//        do{
//            itemArray = try context.fetch(request)
//        }
//        catch{
//            print("Error fetching data from context \(error)")
//        }
//        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}
