//
//  Presenter.swift
//  VIPER Architecture Example
//
//  Created by Leonardo Maia Pugliese on 13/04/21.
//

import Foundation

// object
// protocol
// ref to interactor, router, view

protocol AnyPresenter {
    var router: AnyRouter? { get set }
    var interactor: AnyInteractor? { get set }
    var view: AnyView? { get set}
    
    func interactorDidFetchUsers(with result: Result<[User],Error>)
}

class UserPresenter: AnyPresenter {
    
    var router: AnyRouter?
    var interactor: AnyInteractor? {
        didSet {
            interactor?.getUsers()
        }
    }
    var view: AnyView?
        
    func interactorDidFetchUsers(with result: Result<[User], Error>) {
        switch result {
        case .success(let userList):
            view?.update(with: userList)
        case .failure(_):
            view?.update(with: "Oh man, try again later")
        }
    }

    
}
