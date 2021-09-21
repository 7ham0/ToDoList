//
//  EditTextLayoutService.swift
//  ToDoList
//
//  Created by Giorgi Shamugia on 21.09.21.
//

import UIKit

class EditTextLayoutService: NSObject, UITextViewDelegate {
    
    fileprivate unowned let viewController: AddTaskViewController!
    
    init(viewController: AddTaskViewController){
        self.viewController = viewController
        super.init()
        configure()
    }
    
}

//MARK: - Configure
extension EditTextLayoutService {
    
    func configure() {
        self.configureNavigationBar()
        self.configureTextView()
        self.configureMainView()
        self.configureActionButton()
        
        self.viewController.taskTextView.becomeFirstResponder()
    }
    
    func configureNavigationBar() {
        viewController.navigationController?.navigationBar.isHidden = true
    }
    
    func configureTextView()
    {
        viewController.taskTextView.delegate = viewController
        viewController.taskTextView.placeholder = viewController.placeholder
        viewController.taskTextView.text = viewController.text
        
        viewController.taskTextView.keyboardType = viewController.keyboardType ?? .default
        
        self.updateTextView()
    }
    
    func configureActionButton() {
        viewController.saveTaskButton.isHidden = !viewController.shouldShowActionButton
        viewController.saveTaskButton.isUserInteractionEnabled = viewController.shouldShowActionButton
    }
    
    func updateTextView() {
        let fixedWidth = viewController.taskTextView.frame.size.width
        let newSize = viewController.taskTextView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        viewController.taskTextView.frame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
        
        viewController.wrapperView.layoutIfNeeded()
    }
    
    func configureMainView() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapBackgroundView))
        tapGesture.delegate = viewController
        viewController.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func didTapBackgroundView() {
        viewController.dismiss(animated: true, completion: nil)
    }
}
