//
//  MainViewLayoutService.swift
//  ToDoList
//
//  Created by Giorgi Shamugia on 21.09.21.
//
import UIKit
import CoreData

class MainViewLayoutService: NSObject {
    
    private unowned let viewController: MainViewController
    
    init(viewController: MainViewController) {
        self.viewController = viewController
        super.init()
    }
}
extension MainViewLayoutService: EditTextViewDelegate {
    func didEditText(text: String, index: Int) {
        viewController.data?.filter({$0.isDone != true})[index].task = text
        self.viewController.saveTaskToDatabase()
    }
    
    
    func didSetText(text: String) {
        let newTask = Tasks(context: self.viewController.context)
        newTask.task = text
        newTask.isDone = false
        newTask.date = self.viewController.formatter.string(from: Date())
        self.viewController.saveTaskToDatabase()
    }
}

