//
//  AddTaskKeyboardManager.swift
//  ToDoList
//
//  Created by Giorgi Shamugia on 21.09.21.
//

import UIKit

class AddTaskKeyboardManager: NSObject {
    
    private unowned let controller: AddTaskViewController
    private var keyboardIsShow = false
    var indexPath = IndexPath(row: 0, section: 0)
    
    init(controller: AddTaskViewController) {
        self.controller = controller
        super.init()
        subscribeKeyboardNotification()
    }
    let defaultAnimationDuration: TimeInterval = 0.2
    
    func subscribeKeyboardNotification() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(notification:)),
            name: AddTaskViewController.keyboardWillShowNotification,
            object: nil)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(notification:)),
            name: AddTaskViewController.keyboardWillHideNotification,
            object: nil)
    }
    
    func getKeyboardHeight(_ notification: NSNotification) -> CGFloat {
        var keyboardHeight = CGFloat()
        
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            keyboardHeight = keyboardRectangle.height
        }
        return keyboardHeight
    }
}

// MARK: - Notifications
extension AddTaskKeyboardManager {
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if !keyboardIsShow {
            UIView.animate(withDuration: defaultAnimationDuration, animations: { [weak self] in
                guard let strongSelf = self else { return }
                if let offset = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height {
                    strongSelf.controller.bottomConstraint.constant = offset
                }
            })
            keyboardIsShow = true
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if keyboardIsShow {
            UIView.animate(withDuration: defaultAnimationDuration, animations: { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.controller.bottomConstraint.constant = 0
            })
            keyboardIsShow = false
        }
    }
}

