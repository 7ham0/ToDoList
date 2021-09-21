//
//  UIView.swift
//  ToDoList
//
//  Created by Giorgi Shamugia on 20.09.21.
//

import UIKit

public extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
}
