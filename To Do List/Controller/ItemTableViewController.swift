//
//  ItemTableViewController.swift
//  To Do List
//
//  Created by Muhamed Alkhatib on 04/09/2020.
//

import UIKit
import RealmSwift

class ItemTableViewController: UITableViewController {
    
    var category:Category? {
        didSet {
            print (category?.name)
            itemArray=category?.items.sorted(byKeyPath: "name")
            
        }
    }
    
    let realm = try! Realm()

   // var itemArray=[Item]()
    var itemArray:Results<Item>!

    @IBAction func addItemPressed(_ sender: UIBarButtonItem) {
        
        var alertText=UITextField()
        
        let alert = UIAlertController(title: "Add Item", message: "", preferredStyle: .alert)
        
        let addAction=UIAlertAction(title: "Add", style: .default) { (action) in
            //print("Item is added")
            
            
            let newItem=Item()
            newItem.name=alertText.text!
            
            
            //self.itemArray.append(newItem)
            print(self.itemArray)
            self.tableView.reloadData()
            
            try! self.realm.write {
               // self.realm.add(newItem)
                self.category?.items.append(newItem)
            }
            
            self.tableView.reloadData()
            
            
        }
        
        let cancelAction=UIAlertAction(title: "Cancel", style: .default, handler: nil)
        
        
        alert.addAction(addAction)
        alert.addAction(cancelAction)
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder="Add Item"
            
            alertText=alertTextField
        }
        
        present(alert, animated: true, completion: nil)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        title=category?.name
        //print (print (Realm.Configuration.defaultConfiguration.fileURL))
        
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return itemArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)

        cell.textLabel?.text=itemArray[indexPath.row].name
        
        if itemArray[indexPath.row].checked {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
                

        return cell
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        var item=itemArray[indexPath.row]
        
        try! realm.write{
        item.checked = !item.checked
        }
        
        if item.checked {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        tableView.reloadData()

        
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let item=itemArray[indexPath.row]
        
        try! realm.write {
            realm.delete(item)
        }
        tableView.reloadData()

    }
 

}
