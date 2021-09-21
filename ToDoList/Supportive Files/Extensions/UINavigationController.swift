//
//  UINavigationController.swift
//  ToDoList
//
//  Created by Giorgi Shamugia on 21.09.21.
//

import UIKit

extension UINavigationController {
    public func setupDefaultAppearance(){
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.backgroundColor = .clear
        navigationBar.isTranslucent = false
        navigationBar.barTintColor = UIColor(named: "NavBar_Color")
        navigationBar.tintColor = UIColor.white
        navigationBar.titleTextAttributes = [ NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 18.0)!,
                                              NSAttributedString.Key.foregroundColor: UIColor.white]
        self.setNeedsStatusBarAppearanceUpdate()
    }
}

