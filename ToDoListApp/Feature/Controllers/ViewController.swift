//
//  ViewController.swift
//  ToDoListApp
//
//  Created by Manarbek Bibit on 05.08.2023.
//

import UIKit
import SnapKit
class ViewController: UIViewController {
    // MARK: - Variables
    let tableView = UITableView(frame: CGRectZero, style: .insetGrouped)
    private let model: Model
    let addButton = AddButton()
    private let delegate = BottomSheetTransitioningDelegate(configuration: .default)
    var selectedIndexPath: IndexPath?
    // MARK: - Lifecycle
    init(model: Model) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.model = Model()
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "To Do List"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: nil, image: UIImage(systemName: "list.bullet"), primaryAction: nil, menu: addMenuItems())
        model.readData()
        configureTableView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    // MARK: - Setup TableView and UI
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ToDoTableViewCell.self, forCellReuseIdentifier: "ToDoTableViewCell")
        tableView.backgroundColor = UIColor(red: 0.97, green: 0.96, blue: 0.96, alpha: 1)
        addButton.button.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)
        setupUI()
    }
    private func setupUI() {
        [tableView, addButton].forEach {
            view.addSubview($0)
        }
        tableView.snp.makeConstraints {
            $0.left.equalTo(view.snp.left)
            $0.top.equalTo(view.snp.top)
            $0.right.equalTo(view.snp.right)
            $0.bottom.equalTo(view.snp.bottom)
        }
        addButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-40)
            $0.right.equalToSuperview().offset(-30)
        }
    }
    
    // MARK: - Selector
    @objc private func didTapAddButton() {
        AlertManager.showAlertToAddItems(vc: self, model: model) {
            self.tableView.reloadData()
        }
    }
}

// MARK: - Extension UITableView
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.toDoItems.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoTableViewCell", for: indexPath) as! ToDoTableViewCell
        
        let currentItem = model.toDoItems[indexPath.row]
        cell.label.text = currentItem["title"] as? String
        cell.didTapDone = { [weak self] in
            self?.model.changeState(item: indexPath.row)
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        if (currentItem["isCompleted"] as? Bool) == true {
            cell.image.image = ToDoState.done.icon
        } else {
            cell.image.image = ToDoState.notDone.icon
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedIndexPath = indexPath
        let navVC = DetailViewController()
        let currentText = model.toDoItems[indexPath.row]
        navVC.setTitle(at: currentText["title"] as! String)
        navVC.modalPresentationStyle = .custom
        navVC.transitioningDelegate = self.delegate
        navVC.delegate = self
        self.present(navVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            model.removeItems(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let moveObjects = self.model.toDoItems[sourceIndexPath.item]
        self.model.toDoItems.remove(at: sourceIndexPath.item)
        self.model.toDoItems.insert(moveObjects, at: destinationIndexPath.item)
    }
}
extension ViewController {
    func addMenuItems() -> UIMenu {
        let menuItems = UIMenu(title: "", options: .displayInline, children: [
            UIAction(title: "Add new", image: UIImage(systemName: "plus.circle"), handler: { (_) in
                AlertManager.showAlertToAddItems(vc: self, model: self.model) {
                    self.tableView.reloadData()
                }
            }),
            
            UIAction(title: tableView.isEditing ? "Done" : "Edit", image: UIImage(systemName: "pencil.circle"), handler: { (_) in
                self.tableView.isEditing.toggle()
            })
            
        ])
        
        return menuItems
    }
}

extension ViewController: TransferDataFromBottomSheet {
    func getData(_ text: String) {
        if let selectedIndexPath = selectedIndexPath {
            model.changeText(forRow: selectedIndexPath.row, withText: text)
            tableView.reloadRows(at: [selectedIndexPath], with: .automatic)
        }
    }
}

