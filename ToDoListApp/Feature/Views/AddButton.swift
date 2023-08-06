//
//  AddButton.swift
//  ToDoListApp
//
//  Created by Manarbek Bibit on 05.08.2023.
//

import UIKit
import SnapKit

class AddButton: UIView {
    let button: UIButton = build {
        $0.tintColor = .white
        $0.backgroundColor = .systemBlue
        $0.setImage(UIImage(systemName: "plus"), for: .normal)
        $0.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        $0.layer.cornerRadius = 0.5 * $0.bounds.size.width
        $0.snp.makeConstraints {$0.height.width.equalTo(60)}
    }
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupUI() {
        addSubview(button)
        button.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}
