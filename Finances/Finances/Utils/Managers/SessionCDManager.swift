//
//  SessionCDManager.swift
//  Finances
//
//  Created by DESARROLLO on 22/01/21.
//

import CoreData
import UIKit

struct SessionCDManager {

    static func saveOrUpdate(username: String, lastConnection: Date, isLogged: Bool) -> Bool {
        guard !existsSession(username: username) else {
            return update(username: username,
                   lastConnection: lastConnection,
                   isLogged: isLogged)
        }
        return save(username: username,
                    lastConnection: lastConnection,
                    isLogged: isLogged)
    }

    static func getSessionActive() -> SessionModel? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: SessionModel.entityName)
        let usernameKeyPredicate = NSPredicate(format: "isLogged = %d", true)
        fetchRequest.predicate = usernameKeyPredicate
        do {
            guard let result = try managedContext.fetch(fetchRequest) as? [NSManagedObject],
                  result.isEmpty == false,
                  let sessionFirst = result.first else {
                return nil
            }
            let session = SessionModel(username: sessionFirst.value(forKey: "username") as? String,
                                       lastConnection: sessionFirst.value(forKey: "lastConnection") as? Date,
                                       isLogged: sessionFirst.value(forKey: "isLogged") as? Bool ?? false)
            return session
        } catch let error {
            print("could not get \(error.localizedDescription)")
            return nil
        }
    }
}

private extension SessionCDManager {
    static func update(username: String, lastConnection: Date, isLogged: Bool) -> Bool {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return false }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: SessionModel.entityName)
        let usernameKeyPredicate = NSPredicate(format: "username = %@", username)
        fetchRequest.predicate = usernameKeyPredicate
        do {
            guard let result = try managedContext.fetch(fetchRequest) as? [NSManagedObject],
                  result.isEmpty == false,
                  let sessionFirst = result.first else {
                return false
            }
            sessionFirst.setValue(isLogged, forKey: "isLogged")
            sessionFirst.setValue(lastConnection, forKey: "lastConnection")
            try managedContext.save()
            return true
        } catch {
            return false
        }
    }

    static func save(username: String, lastConnection: Date, isLogged: Bool) -> Bool {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return false }
        let managedContext = appDelegate.persistentContainer.viewContext
        guard let entityName = NSEntityDescription.entity(forEntityName: SessionModel.entityName,
                                                          in: managedContext) else {
            return false
        }
        let entity = NSManagedObject(entity: entityName, insertInto: managedContext)
        entity.setValue("\(username)", forKey: "username")
        entity.setValue(lastConnection, forKey: "lastConnection")
        entity.setValue(isLogged, forKey: "isLogged")
        do {
            try managedContext.save()
            return true
        } catch let error {
            print("could not save \(error.localizedDescription)")
            return false
        }
    }

    static func existsSession(username: String) -> Bool {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return false }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: SessionModel.entityName)
        let usernameKeyPredicate = NSPredicate(format: "username = %@", username)
        fetchRequest.predicate = usernameKeyPredicate
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
}
