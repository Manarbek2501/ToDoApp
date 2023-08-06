//
//  Builder.swift
//  ToDoListApp
//
//  Created by Manarbek Bibit on 05.08.2023.
//

import Foundation
import UIKit

/** Simplifies building objects

    Old example

        private var amountLabel: UILabel = {
            let label = UILabel()
            label.font = .systemFont(ofSize: 17, weight: .semibold)
            label.textColor = .textPrimary.color
            return label
        }()

    vs new example

        private let amountLabelNew: UILabel = build(.init()) {
            $0.font = .systemFont(ofSize: 17, weight: .semibold)
            $0.textColor = .textPrimary.color
        }
 */
public func build<T>(_ object: T, builder: (T) -> Void) -> T {
    builder(object)
    return object
}

/** Simplifies building NSObject

   Old example

       private var amountLabel: UILabel = {
           let label = UILabel()
           label.font = .systemFont(ofSize: 17, weight: .semibold)
           label.textColor = .textPrimary.color
           return label
       }()

   vs new example

       private let amountLabelNew: UILabel = build {
           $0.font = .systemFont(ofSize: 17, weight: .semibold)
           $0.textColor = .textPrimary.color
       }
*/
public func build<T: NSObject>(builder: (T) -> Void) -> T {
    build(T(), builder: builder)
}
