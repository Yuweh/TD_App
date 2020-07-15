//
//  ToDoListVC.swift
//  TDA
//
//  Created by Francis Yuweh on 7/15/20.
//  Copyright © 2020 Francis B. All rights reserved.
//

import UIKit
import RealmSwift

class ToDoListVC: UIViewController {
    
    
    @IBOutlet weak var completeNumLbl: UILabel!
    @IBOutlet weak var onGoingNumLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    private var items: Results<ToDoItem>?
    
    // MARK: - ViewController life-cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        items = ToDoItem.all()
        self.tableView.reloadData()
        self.tableView.isHidden = items?.count == 0 ? true : false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

    }
    
    func toggleItem(_ item: ToDoItem) {
        item.toggleCompleted()
    }
    
    func deleteItem(_ item: ToDoItem) {
        item.delete()
    }
}

extension ToDoListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "DELETE") { (rowAction, indexPath) in
            guard let item = self.items?[indexPath.row] else { return }
            self.deleteItem(item)
            self.tableView.reloadData()
            self.tableView.isHidden = self.items?.count == 0 ? true : false
        }
        
        let addAction = UITableViewRowAction(style: .normal, title: "MARK\nCOMPLETE✅") { (rowAction, indexPath) in
            guard let item = self.items?[indexPath.row] else { return }
            self.toggleItem(item)
            self.tableView.reloadData()
            self.tableView.isHidden = self.items?.count == 0 ? true : false
        }
        
        deleteAction.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        addAction.backgroundColor = #colorLiteral(red: 0.961445272, green: 0.650790751, blue: 0.1328578591, alpha: 1)
        return [deleteAction, addAction]
    }
    
}

extension ToDoListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath) as? ToDoTVCell,
            let item = items?[indexPath.row] else {
                return ToDoTVCell(frame: .zero)
        }
        
        cell.configureWith(item) { [weak self] item in
            self?.toggleItem(item)
        }
        
        return cell
    }
}
