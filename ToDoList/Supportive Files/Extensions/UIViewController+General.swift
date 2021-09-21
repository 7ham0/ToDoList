//
//  UIViewController+General.swift
//  ToDoList
//
//  Created by Giorgi Shamugia on 21.09.21.
//

public extension BaseVC {
    
    /// RDExtensionsSwift: Present view controller on recever
    func present(_ viewControllerToPresent: BaseVC, animated: Bool = false)
    {
        self.present(viewControllerToPresent, animated: animated, completion: nil)
    }
    
    /// RDExtensionsSwift: Present receiver on view controller
    func present(on viewController: BaseVC, animated: Bool = true, completion: (() -> Void)? = nil)
    {
        viewController.present(self, animated: animated, completion: completion)
    }
}
