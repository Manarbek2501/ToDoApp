//
//  AlertManager.swift
//  ToDoListApp
//
//  Created by Manarbek Bibit on 05.08.2023.
//

import UIKit

class AlertManager {
    
    private static func showBasicAlert(vc: UIViewController, model: Model, addAction: @escaping () -> Void?) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "New Item", message: "Enter new to do item here", preferredStyle: .alert)
            alert.addTextField { field in
                field.placeholder = "Enter your item...."
            }
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { (_) in
                if let field = alert.textFields?.first {
                    if let text = field.text, !text.isEmpty {
                        DispatchQueue.main.async {
                            model.addItems(titleOfItem: text)
                            addAction()
                        }
                    }
                }
            }))
            vc.present(alert, animated: true)
        }
    }
}

extension AlertManager {
    public static func showAlertToAddItems(vc: UIViewController, model: Model, addAction: @escaping () -> Void?) {
        self.showBasicAlert(vc: vc, model: model, addAction: addAction)
    }
}
