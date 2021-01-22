//
//  UserCoreDataManager.swift
//  Finances
//
//  Created by DESARROLLO on 22/01/21.
//

import CoreData
import UIKit
import CryptoKit

struct UserCDManager {

    static func save(username: String, password: String, name: String) -> Bool {
        guard !existsUser(username: username, password: password) else {
            return false
        }
        guard let passwordHash = getPasswordHash(password: password) else {
            return false
        }
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return false }
        let managedContext = appDelegate.persistentContainer.viewContext
        guard let userEntity = NSEntityDescription.entity(forEntityName: UserModel.entityName, in: managedContext) else {
            return false
        }
        let counter = NSManagedObject(entity: userEntity, insertInto: managedContext)
        counter.setValue("\(username)", forKey: "username")
        counter.setValue("\(passwordHash)", forKey: "password")
        counter.setValue("\(name)", forKey: "name")
        do {
            try managedContext.save()
            return true
        } catch let error {
            print("could not save \(error.localizedDescription)")
            return false
        }
    }

    static func existsUser(username: String, password: String) -> Bool {
        guard let passwordHash = getPasswordHash(password: password) else {
            return true
        }
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return false }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: UserModel.entityName)
        let usernameKeyPredicate = NSPredicate(format: "username = %@", username)
        let passwordKeyPredicate = NSPredicate(format: "password = %@", passwordHash)
        let andPredicate = NSCompoundPredicate(type: NSCompoundPredicate.LogicalType.and,
                                               subpredicates: [usernameKeyPredicate, passwordKeyPredicate])
        fetchRequest.predicate = andPredicate
        do {
            guard let result = try managedContext.fetch(fetchRequest) as? [NSManagedObject],
                  result.isEmpty == false else {
                return false
            }
            return true
        } catch let error {
            print("could not get \(error.localizedDescription)")
            return false
        }
    }

    static private func getPasswordHash(password: String) -> String? {
        guard let passwordData = password.data(using: .utf8) else {
            return nil
        }
        let passwordHash = SHA256.hash(data: passwordData)
        let hashString = passwordHash.compactMap { String(format: "%02x", $0) }.joined()
        return hashString
    }
}
