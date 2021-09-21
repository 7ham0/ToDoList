//
//  AddTaskViewController.swift
//  ToDoList
//
//  Created by Giorgi Shamugia on 21.09.21.
//

import UIKit

class AddTaskViewController: BaseVC, Storyboardable, UIGestureRecognizerDelegate {
    @IBOutlet weak var wrapperView: UIView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var taskTextView: UITextView!
    @IBOutlet weak var saveTaskButton: UIButton!
    var typeOfController: typeOfControllers = .forNew
    
    // - Managers
    fileprivate var layoutService: EditTextLayoutService!
    fileprivate var keyboardManager: AddTaskKeyboardManager!
    
    // - Init Storyboard
    static var storyboardName: String = "Main"
    static var storyboardIdentifier: String = "sddTaskVC"
    static var storyboardBundle: Bundle = .main
    
    // - Data
    var text: String = "" //TODO: title Text Implementation
    var titleText: String = ""
    var placeholder: String = "" //TODO: placeholder
    var dataIndex: Int = 0
    var delegate: EditTextViewDelegate?
    var keyboardType: UIKeyboardType?
    var shouldShowActionButton = true
    
    // - Enum
    enum typeOfControllers {
        case forNew
        case forEdit
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view?.isDescendant(of: self.wrapperView) == true {
            return false
        }
        return true
    }
    
    @IBAction func didTapOnSave(_ sender: Any) {
        switch typeOfController {
        case .forNew:
            self.delegate?.didSetText(text: self.text)
        case .forEdit:
            self.delegate?.didEditText(text: self.text, index: dataIndex)
        }
        
    }
}

extension AddTaskViewController {
    func configure() {
        setupLayoutService()
        setupKeyboardService()
        setupView()
    }
    
    func setupLayoutService() {
        layoutService = EditTextLayoutService(viewController: self)
    }
    
    func setupKeyboardService() {
        keyboardManager = AddTaskKeyboardManager(controller: self)
    }
    
    func setupView(){
        self.taskTextView.delegate = self
        self.setNavBarVisible(false, animated: true)
    }
}

//MARK: - UITextView
extension AddTaskViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        self.text = taskTextView.text
        self.layoutService.updateTextView()
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            self.delegate?.didSetText(text: self.text)
            self.dismiss(animated: true, completion: nil)
            return false
        }
        return true
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if !self.shouldShowActionButton {
            self.delegate?.didSetText(text: self.text)
        }
    }
}
