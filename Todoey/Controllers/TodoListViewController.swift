//
//  ViewController.swift
//  Todoey
//
//  Created by Sona Mohan on 2018-11-14.
//  Copyright © 2018 Sona Mohan. All rights reserved.
//

import UIKit
import RealmSwift
import CoreData

class TodoListViewController: UITableViewController{
    
    let realm = try! Realm()
    var todoItems: Results<Item>?
    var selectedCategory : Category? {
        didSet {
            loadItems()
        }
    }
    
   
    
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
        return todoItems?.count ?? 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        if let item = todoItems?[indexPath.row] {
        
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
        }
        else{
            cell.textLabel?.text = "No Items Added"
        }
        return cell
    }
    
    
    //Mark - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         //print(itemArray[indexPath.row])
        
        if let item = todoItems?[indexPath.row]
        {
            do{
               try realm.write {
                    //realm.delete(item)
                    item.done = !item.done
                }
            }catch{
                    print("Error saving the status of item, \(error)")
                }
            }
        tableView.reloadData()
        
        //context.delete(itemArray[indexPath.row])
        //itemArray.remove(at: indexPath.row)
        
        
//        todoItems[indexPath.row].done = !todoItems[indexPath.row].done
//        saveItems()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // Mark - Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new Todoey item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default){(action) in
            //what will happen once the user clicks the Add item button on our UIAlert
            if let currentCategory = self.selectedCategory{
                do{
                    
                    try self.realm.write{
                    let newItem = Item()
                    newItem.dateCreated = Date()
                    newItem.title = textField.text!
                        
                        //date = newItem.dateCreated
                    currentCategory.items.append(newItem)
                    }
                }catch{
                        print("Error saving category, \(error)")
                    }
                }
            
            
            //newItem.parentCategory = self.selectedCategory
            
        self.tableView.reloadData()
            
        }
        alert.addTextField{ (alertTextfield) in
            alertTextfield.placeholder = "Create new item"
            textField = alertTextfield
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
//     func saveItems()
//     {
//
//        //let encoder = PropertyListEncoder()
//        do{
//
//            try context.save()
//        }
//        catch{
//            print("Error saving context, \(error)")
//        }
//
//        tableView.reloadData()
//    }
   func loadItems()
   {
    todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending : true)
       tableView.reloadData()
  
    
}
}

extension TodoListViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending : true)
        
        tableView.reloadData()
//        let request : NSFetchRequest<Item> = Item.fetchRequest()
//        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
//
//        request.sortDescriptors = [NSSortDescriptor(key : "title", ascending : true)]
//        loadItems(with: request, predicate: predicate)
//
//     do{
//           itemArray = try context.fetch(request)
//     }
//      catch{
//           print("Error fetching data from context \(error)")
//       }
//
    }

   func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
      if searchBar.text?.count == 0 {

           DispatchQueue.main.async {
             searchBar.resignFirstResponder()
         }
      }
 }
}

