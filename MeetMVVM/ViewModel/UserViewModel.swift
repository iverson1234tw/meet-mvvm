//
//  UserViewModel.swift
//  MeetMVVM
//
//  Created by Josh on 2023/12/21.
//

import CoreData

class UserViewModel {

    // coreDataManager init
    private let coreDataManager = CoreDataManager.shared
    
    // MARK: - getUsers
    func getUsers() -> [UserModel] {
        coreDataManager.fetchUsers()
    }
    
    // MARK: - addUser
    func addUser(userModel: UserModel) {
        coreDataManager.saveUser(userModel: userModel)
    }

    // MARK: - deleteUser
    func deleteUser(userModel: UserModel) {
        coreDataManager.deleteUser(userModel: userModel)
    }
    
}
