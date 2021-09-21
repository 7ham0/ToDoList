//
//  BaseVC.swift
//  ToDoList
//
//  Created by Giorgi Shamugia on 20.09.21.
//

import UIKit

open class BaseVC: UIViewController {
    // required in each VC that subclass this one
    open class var storyboardName: String {
        return "Main"
    }
    open class var viewControllerId: String {
        return "mainVC"
    }
    
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
    
    var isModal: Bool {
        if let index = navigationController?.viewControllers.firstIndex(of: self), index > 0 {
            return false
        } else if presentingViewController != nil {
            return true
        } else if let navigationController = navigationController, navigationController.presentingViewController?.presentedViewController == navigationController {
            return true
        } else {
            return false
        }
    }
    
    @objc open func closeVC() {
        if self.isModal {
            self.dismiss(animated: true)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    open class func fromStoryboard() -> Self {
        if #available(iOS 13.0, *) {
            return UIStoryboard.init(name: self.storyboardName, bundle: nil).instantiateViewController(identifier: self.viewControllerId)
        } else {
            return UIStoryboard.init(name: self.storyboardName, bundle: nil).instantiateViewController(withIdentifier: self.viewControllerId) as! Self
        }
    }
    
    open class func inNavigationController() -> UINavigationController {
        return TDNavigationController(rootViewController: self.fromStoryboard())
    }
}
