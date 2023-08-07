//
//  DetailViewController.swift
//  ToDoListApp
//
//  Created by Manarbek Bibit on 06.08.2023.
//

import UIKit
import SnapKit

protocol TransferDataFromBottomSheet: NSObject {
    func getData(_ text: String)
}

class DetailViewController: UIViewController {
    //MARK: - UI Components
    let details = BottomSheetView()
    weak var delegate: TransferDataFromBottomSheet?
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.details.delegate = self
        setupUI()
    }
    
    //MARK: - Setup UI
    private func setupUI() {
        view.addSubview(details)
        details.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(200)
        }
    }
    
    func setTitle(at text: String) {
        self.details.textField.text = text
    }
    //MARK: - Selectors
    
}

//MARK: - Extension
extension DetailViewController: BottomSheetViewDelegate {
    func buttonDidTapped(_ text: String) {
        delegate?.getData(text)
        self.dismiss(animated: true)
    }
}
