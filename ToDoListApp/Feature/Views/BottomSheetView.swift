//
//  BottomSheetView.swift
//  ToDoListApp
//
//  Created by Manarbek Bibit on 06.08.2023.
//

import UIKit
import SnapKit

protocol BottomSheetViewDelegate: NSObject {
    func buttonDidTapped(_ text: String)
}

class BottomSheetView: UIView {
    // MARK: - UI Components
    let textField = CustomTextField(fieldType: .toDoItem)
    let saveButton: UIButton = build {
        $0.setTitle("Save", for: .normal)
        $0.setTitleColor(.systemBlue, for: .normal)
        $0.addTarget(self, action: #selector(saveDidTapped), for: .touchUpInside)
    }
    var datePicker: UIDatePicker = build {
        $0.date = Date()
        $0.locale = .current
        $0.preferredDatePickerStyle = .compact
    }
    
    weak var delegate: BottomSheetViewDelegate?
    
    // MARK: - UI Lifecycle
    init() {
        super.init(frame: .zero)
        self.backgroundColor = .white
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup UI Components
    private func setupUI() {
        [saveButton ,textField, datePicker].forEach {
            addSubview($0)
        }
        saveButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(2)
            $0.right.equalToSuperview().offset(-16)
        }
        textField.snp.makeConstraints {
            $0.top.equalTo(saveButton.snp.bottom).offset(15)
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(56)
        }
        datePicker.snp.makeConstraints {
            $0.top.equalTo(textField.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
    }
    // MARK: - Selectors
    @objc func saveDidTapped() {
        guard let textFieldText = textField.text else {return}
        delegate?.buttonDidTapped(textFieldText)
    }
}
