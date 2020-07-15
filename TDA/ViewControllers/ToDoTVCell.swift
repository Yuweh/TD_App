//
//  ToDoTVCell.swift
//  TDA
//
//  Created by Francis Yuweh on 7/15/20.
//  Copyright © 2020 Francis B. All rights reserved.
//

import UIKit

class ToDoTVCell: UITableViewCell {
    private var onToggleCompleted: ((ToDoItem) -> Void)?
    private var item: ToDoItem?
    
    @IBOutlet private var label: UILabel!
    @IBOutlet private var button: UIButton!
    @IBOutlet weak var goalCompleteLabel: UIView!
    @IBAction private func toggleCompleted() {
        guard let item = item else { fatalError("Missing Todo Item") }
        onToggleCompleted?(item)
    }
    
    func configureWith(_ item: ToDoItem, onToggleCompleted: ((ToDoItem) -> Void)? = nil) {
        self.item = item
        self.onToggleCompleted = onToggleCompleted
        label.attributedText = NSAttributedString(string: item.text,
                                                  attributes: item.isCompleted ? [.strikethroughStyle: true] : [:])
        button.setTitle(item.isCompleted ? "✅": "◻️", for: .normal)
        self.goalCompleteLabel.isHidden = item.isCompleted ? false : true
    }
}
