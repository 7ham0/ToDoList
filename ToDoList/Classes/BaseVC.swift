//
//  BaseVC.swift
//  ToDoList
//
//  Created by Giorgi Shamugia on 20.09.21.
//

import UIKit

open class BaseVC: UIViewController {
    
    open func pushController(_ vc: UIViewController, animated: Bool = true) {
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(vc, animated: animated)
        }
    }
    
    open func presentController(_ vc: UIViewController, animated: Bool = true) {
        DispatchQueue.main.async {
            self.navigationController?.present(vc, animated: true, completion: nil)
        }
    }
    
    open func setNavBarVisible(_ visible: Bool, animated: Bool = false) {
        self.navigationController?.setNavigationBarHidden(!visible, animated: animated)
    }
    
    open func hideNavBar(animated: Bool = false) {
        self.setNavBarVisible(false, animated: animated)
    }
    
    open func showNavBar(animated: Bool = false) {
        self.setNavBarVisible(true, animated: animated)
    }
}
