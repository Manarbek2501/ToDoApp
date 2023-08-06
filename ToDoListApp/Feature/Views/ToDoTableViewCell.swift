//
//  ToDoTableViewCell.swift
//  ToDoListApp
//
//  Created by Manarbek Bibit on 05.08.2023.
//

import UIKit
import SnapKit

class ToDoTableViewCell: UITableViewCell {
    //MARK: - Variables
    let label: UILabel = build {
        $0.numberOfLines = 0
        $0.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
    }
    let image: UIImageView = build {
        $0.tintColor = .black
    }
    var model: Model?
    //MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - SetupUI and ConfigureUI
    func configureCell(model: Model) {
        self.model = model
    }
    private func setupUI() {
        [label, image].forEach {
            contentView.addSubview($0)
        }
        label.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().offset(16)
        }
        image.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().offset(-16)
        }
    }
}
