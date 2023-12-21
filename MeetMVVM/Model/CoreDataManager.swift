//
//  CoreDataManager.swift
//  MeetMVVM
//
//  Created by ChinWei Liu on 2023/12/21.
//

import CoreData

class CoreDataManager {

    // shared init
    static let shared = CoreDataManager()
    
    private init() {}
    
    // persistentContainer lazy var
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "UserCoreData")
            container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - fetchUsers
    func fetchUsers() -> [UserModel] {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        do {
            let users = try context.fetch(fetchRequest)
            return users.map {
                return UserModel(id: Int($0.id),
                                 name: $0.name ?? "",
                                 phoneNumber: $0.phoneNumber ?? "",
                                 address: $0.address ?? "")
            }
        } catch {
            fatalError("Failed to fetch users: \(error)")
        }
    }
    
    // MARK: - saveUser
    func saveUser(userModel: UserModel) {
        let context = persistentContainer.viewContext
        let user = User(context: context)
        user.id = Int32(userModel.id)
        user.name = userModel.name
        user.phoneNumber = userModel.phoneNumber
        user.address = userModel.address

        do {
            try context.save()
        } catch {
            fatalError("Failed to save user: \(error)")
        }
    }
    
    // MARK: - deleteUser
    func deleteUser(userModel: UserModel) {
        let context = persistentContainer.viewContext

        // Assuming there's a function userModel(from:) that converts UserModel to User
        if let user = fetchUserById(userModel.id, in: context) {
            context.delete(user)
        }

        do {
            try context.save()
        } catch {
            fatalError("Failed to delete user: \(error)")
        }
    }
    
    // MARK: - fetchUserById
    private func fetchUserById(_ userId: Int, in context: NSManagedObjectContext) -> User? {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", userId)

        do {
            let users = try context.fetch(fetchRequest)
            return users.first
        } catch {
            fatalError("Failed to fetch user by id: \(error)")
        }
    }
    
}
