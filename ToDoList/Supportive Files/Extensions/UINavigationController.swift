//
//  UINavigationController.swift
//  ToDoList
//
//  Created by Giorgi Shamugia on 21.09.21.
//

import UIKit

extension UINavigationController {
    public func setupDefaultAppearance(){
        if #available(iOS 15.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor(named: "NavBar_Color")
            appearance.titleTextAttributes = [ NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 18.0)!,
                                               NSAttributedString.Key.foregroundColor: UIColor.white]
//            appearance.largeTitleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16.5) as Any, NSAttributedString.Key.foregroundColor: UIColor.white]
            appearance.backgroundImage = UIImage()
            appearance.shadowImage = UIImage()
            navigationBar.standardAppearance = appearance
            navigationBar.scrollEdgeAppearance = appearance
        } else {
            self.navigationBar.setBackgroundImage(UIImage(), for: .default)
            self.navigationBar.shadowImage = UIImage()
            self.navigationBar.backgroundColor = .clear
            self.navigationBar.barTintColor = UIColor(named: "NavBar_Color")
            self.navigationBar.tintColor = UIColor.white
            self.navigationBar.titleTextAttributes = [ NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 18.0)!,
                                                  NSAttributedString.Key.foregroundColor: UIColor.white]
            self.setNeedsStatusBarAppearanceUpdate()
        }
        
    }
}

