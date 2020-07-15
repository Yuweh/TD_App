//
//  ToAddVC.swift
//  TDA
//
//  Created by Francis Yuweh on 7/15/20.
//  Copyright © 2020 Francis B. All rights reserved.
//

import UIKit

class ToAddVC: UIViewController, UITextViewDelegate {

    @IBOutlet weak var toDoTitle: UITextView!
    @IBOutlet weak var createGoalBtnLbl: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createGoalBtnLbl.bindToKeyboard()
        self.toDoTitle.delegate = self
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        self.toDoTitle.text = ""
        self.toDoTitle.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }

    @IBAction func createGoalBtnTapped(_ sender: Any) {
        if !self.toDoTitle.text.isEmpty {
            self.dismiss(animated: true) {
                ToDoItem.add(text: self.toDoTitle.text)
            }
        }
    }
    
    
    @IBAction func closeBtnTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
