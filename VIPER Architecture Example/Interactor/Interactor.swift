//
//  Interactor.swift
//  VIPER Architecture Example
//
//  Created by Leonardo Maia Pugliese on 13/04/21.
//

import Foundation

// object
// protocol
// ref to presenter

// https://jsonplaceholder.typicode.com/users

protocol AnyInteractor {
    var presenter: AnyPresenter? { get set }
    
    func getUsers()
    
}

enum NetworkErrors: Error {
    case failedToGetFromNetwork
    case failedToParseFromNetwork
}

class UserInteractor: AnyInteractor {
    var presenter: AnyPresenter?
    
    func getUsers() {
        let task = URLSession.shared.dataTask(with: URL(string: "https://jsonplaceholder.typicode.com/users")!) { [weak self] data, _ , error in
            
            guard let data = data, error == nil else {
                self?.presenter?.interactorDidFetchUsers(with: .failure(NetworkErrors.failedToGetFromNetwork))
                return
            }
            
            if let usersList = try? JSONDecoder().decode([User].self, from: data) {
                self?.presenter?.interactorDidFetchUsers(with: .success(usersList))
            } else {
                self?.presenter?.interactorDidFetchUsers(with: .failure(NetworkErrors.failedToParseFromNetwork))
            }
            
        }
        task.resume()
    }
}
