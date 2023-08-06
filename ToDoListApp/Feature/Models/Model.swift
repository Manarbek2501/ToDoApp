//
//  Model.swift
//  ToDoListApp
//
//  Created by Manarbek Bibit on 05.08.2023.
//

import UIKit

class Model {
    var toDoItems = [[String : Any]]()
    
    func addItems(titleOfItem: String, isCompleted: Bool = false) {
        toDoItems.append(["title" : titleOfItem, "isCompleted" : isCompleted])
        saveData()
    }
    
    func changeState(item: Int) {
        toDoItems[item]["isCompleted"] = !(toDoItems[item]["isCompleted"] as! Bool)
        saveData()
    }
    
    func saveData() {
        UserDefaults.standard.set(toDoItems, forKey: "itemsDataToDo")
        UserDefaults.standard.synchronize()
    }
    
    func readData() {
        if let savedItems = UserDefaults.standard.array(forKey: "itemsDataToDo") as? [[String: Any]] {
            toDoItems = savedItems
        } else {
            toDoItems = []
        }
    }
}
