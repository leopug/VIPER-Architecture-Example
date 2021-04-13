//
//  Router.swift
//  VIPER Architecture Example
//
//  Created by Leonardo Maia Pugliese on 13/04/21.
//

import UIKit

// Object
// entry point for the architecture

protocol AnyRouter {
    var view: (AnyView & UIViewController)? { get set }
    
    static func beginFlow() -> AnyRouter
    
}

class UserRouter: AnyRouter {
    var view: (UIViewController & AnyView)?
    
    static func beginFlow() -> AnyRouter {
        let router = UserRouter()
        
        // assign View, interactor , presenter
        let view = UserViewController()
        let presenter = UserPresenter()
        let interactor = UserInteractor()
        
        view.presenter = presenter
        
        interactor.presenter = presenter
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        router.view = view 
        
        return router
    }
    
    	
}
