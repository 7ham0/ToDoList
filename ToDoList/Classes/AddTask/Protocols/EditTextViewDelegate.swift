//
//  EditTextViewDelegate.swift
//  ToDoList
//
//  Created by Giorgi Shamugia on 21.09.21.
//

import UIKit

protocol EditTextViewDelegate: AnyObject {
    func didSetText(text: String)
}

