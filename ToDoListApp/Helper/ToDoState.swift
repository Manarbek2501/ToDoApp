//
//  ToDoState.swift
//  ToDoListApp
//
//  Created by Manarbek Bibit on 05.08.2023.
//

import Foundation
import UIKit

enum ToDoState {
    case done
    case notDone

    var icon: UIImage? {
        switch self {
        case .done:
            return UIImage(systemName: "checkmark.circle.fill")
        case .notDone:
            return UIImage(systemName: "circle")
        }
    }
}

