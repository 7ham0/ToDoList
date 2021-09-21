//
//  CompletedTaskDelegate.swift
//  ToDoList
//
//  Created by Giorgi Shamugia on 21.09.21.
//

import UIKit

protocol CompletedTaskDelegate: AnyObject {
    func didTapOnDone(index: Int)
}
