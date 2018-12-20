//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Sona Mohan on 2018-12-17.
//  Copyright © 2018 Sona Mohan. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    var categories = [Category]()
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
       
    }
    
    // Mark: - Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
         cell.textLabel?.text  = categories[indexPath.row].name
        
        return cell
    }
    
    
    //Mark: - Tableview Data Manipulation Methods
    
    func saveCategories()
    {
        
        //let encoder = PropertyListEncoder()
        do{
            
            try context.save()
        }
        catch{
            print("Error saving category, \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadCategories(with request:NSFetchRequest<Category> = Category.fetchRequest())
    {
        //let request: NSFetchRequest<Item> = Item.fetchRequest()
        do{
            categories = try context.fetch(request)
        }
        catch{
            print("Error loading categories from context \(error)")
        }
        tableView.reloadData()
    }
    
    //Mark: - Add New Categories

 
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default){(action) in
            //what will happen once the user clicks the Add item button on our UIAlert
            
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text!
            
            
            self.categories.append(newCategory)
            
            self.saveCategories()
            
            
            
        }
        alert.addTextField{ (field) in
            field.placeholder = "Create new category"
            textField = field
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
        
    }
    
    
    //Mark: - Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory = categories[indexPath.row]
        }
        
    }
    
}
