//
//  TDNavigationController.swift
//  ToDoList
//
//  Created by Giorgi Shamugia on 20.09.21.
//

import UIKit

public class TDNavigationController: UINavigationController {
    public override func viewDidLoad() {
        super.viewDidLoad()
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
    
    public override var preferredStatusBarStyle : UIStatusBarStyle {
        if let topVC = viewControllers.last {
            return topVC.preferredStatusBarStyle
        }
        return .default
    }
}
