//
//  CustomTextField.swift
//  ToDoListApp
//
//  Created by Manarbek Bibit on 06.08.2023.
//

import UIKit

class CustomTextField: UITextField {
    
    enum CustomTextFieldType {
        case toDoItem
    }
    private let authFieldType: CustomTextFieldType
    
    init(fieldType: CustomTextFieldType) {
        self.authFieldType = fieldType
        super.init(frame: .zero)
        self.backgroundColor = .secondarySystemBackground
        self.layer.cornerRadius = 10
        
        self.returnKeyType = .done
        self.autocorrectionType = .no
        self.autocapitalizationType = .none
        
        self.leftViewMode = .always
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: self.frame.size.height))
        switch fieldType {
        case .toDoItem:
            self.placeholder = "Replace your text..."
            self.keyboardType = .default
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

