//
//  SessionCDManager.swift
//  Finances
//
//  Created by DESARROLLO on 22/01/21.
//

import CoreData
import UIKit

protocol SessionCDManagerProtocol {
    static func getSessionActive() -> SessionModel?
    static func saveOrUpdate(session: SessionModel) -> Bool
    static func updateLastConnection(session: SessionModel) -> Bool
    static func inactiveSession(session: SessionModel) -> Bool
}

struct SessionCDManager {

    static private var managedContext: NSManagedObjectContext? {
        get {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return nil
            }
            return appDelegate.persistentContainer.viewContext
        }
    }
}

// MARK: - SessionCDManagerProtocol
extension SessionCDManager: SessionCDManagerProtocol {

    static func inactiveSession(session: SessionModel) -> Bool {
        let inactive = SessionModel(isLogged: false,
                                   username: session.username,
                                   currentConnection: session.currentConnection,
                                   lastConnection: session.lastConnection)
        return update(session: inactive)
    }

    static func updateLastConnection(session: SessionModel) -> Bool {
        let newSession = SessionModel(isLogged: session.isLogged,
                                      username: session.username,
                                      currentConnection: Date(),
                                      lastConnection: session.currentConnection)
        return update(session: newSession)
    }

    static func saveOrUpdate(session: SessionModel) -> Bool {
        guard !existsSession(username: session.username) else {
            return update(session: session)
        }
        return save(session: session)
    }

    static func getSessionActive() -> SessionModel? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: SessionEntity.entityName.rawValue)
        let usernameKeyPredicate = NSPredicate(format: "\(SessionEntity.isLogged.rawValue) = %d",
                                               true)
        fetchRequest.predicate = usernameKeyPredicate
        do {
            guard let result = try managedContext?.fetch(fetchRequest) as? [NSManagedObject],
                  result.isEmpty == false,
                  let sessionFirst = result.first else {
                return nil
            }
            guard let isLogged = sessionFirst.value(forKey: SessionEntity.isLogged.rawValue) as? Bool,
                  let username = sessionFirst.value(forKey: SessionEntity.username.rawValue) as? String,
                  let currentConnection = sessionFirst.value(forKey: SessionEntity.currentConnection.rawValue) as? Date else {
                return nil
            }
            let lastConnection = sessionFirst.value(forKey: SessionEntity.lastConnection.rawValue) as? Date
            let session = SessionModel(isLogged: isLogged,
                                       username: username,
                                       currentConnection: currentConnection,
                                       lastConnection: lastConnection)
            return session
        } catch let error {
            print("Error in getSessionActive \(error.localizedDescription)")
            return nil
        }
    }
}

private extension SessionCDManager {

    static func getSession(username: String) -> NSManagedObject? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: SessionEntity.entityName.rawValue)
        let usernameKeyPredicate = NSPredicate(format: "\(SessionEntity.username.rawValue) = %@",
                                               username)
        fetchRequest.predicate = usernameKeyPredicate
        do {
            guard let result = try managedContext?.fetch(fetchRequest) as? [NSManagedObject],
                  result.isEmpty == false,
                  let sessionFirst = result.first else {
                return nil
            }
            return sessionFirst
        } catch {
            return nil
        }
    }

    static func update(session: SessionModel) -> Bool {
        guard let sessionFirst = getSession(username: session.username) else {
            return false
        }
        do {
            sessionFirst.setValue(session.isLogged,
                                  forKey: SessionEntity.isLogged.rawValue)
            let currentConnection = sessionFirst.value(forKey: SessionEntity.currentConnection.rawValue)
            sessionFirst.setValue(currentConnection,
                                  forKey: SessionEntity.lastConnection.rawValue)
            sessionFirst.setValue(session.currentConnection,
                                  forKey: SessionEntity.currentConnection.rawValue)
            try managedContext?.save()
            return true
        } catch {
            return false
        }
    }

    static func save(session: SessionModel) -> Bool {
        guard let managedContext = managedContext else {
            return false
        }
        guard let entityName = NSEntityDescription.entity(forEntityName: SessionEntity.entityName.rawValue,
                                                          in: managedContext) else {
            return false
        }
        let entity = NSManagedObject(entity: entityName, insertInto: managedContext)
        entity.setValue(session.username,
                        forKey: SessionEntity.username.rawValue)
        entity.setValue(session.currentConnection,
                        forKey: SessionEntity.lastConnection.rawValue)
        entity.setValue(session.currentConnection,
                        forKey: SessionEntity.currentConnection.rawValue)
        entity.setValue(session.isLogged,
                        forKey: SessionEntity.isLogged.rawValue)
        do {
            try managedContext.save()
            return true
        } catch let error {
            print("Error in save Session \(error.localizedDescription)")
            return false
        }
    }

    static func existsSession(username: String) -> Bool {
        return getSession(username: username) != nil
    }
}
