//
//  CoreDataManager.swift
//  NotesApp
//
//  Created by Omer Elimelech on 29/01/2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import Foundation
import UIKit
import CoreData
enum error : Error {
    case myerror
}


typealias fetchResult<T: NSManagedObject> = Result<[T]?, Error>
typealias fetchComplation<T: NSManagedObject> = (_ result: fetchResult<T>) -> Void


class CoreDataManager: NSObject {
    
    static let shared = CoreDataManager()
    
    lazy var appDelegate: AppDelegate? = {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {return nil}
        return delegate
    }()

    private var managedContext: NSManagedObjectContext? {
        return appDelegate?.persistentContainer.viewContext
    }
    
    public func getEntity<T: NSManagedObject>(forType type: T.Type, entityName: String) -> T? {
        guard let managedContext = self.managedContext else {return nil}
        return T(context: managedContext)
    }
    func get<T: NSManagedObject>(type: T.Type, entityName: String, predicate: NSPredicate?, completion: @escaping fetchComplation<T>) {
        let fetchRequest = NSFetchRequest<T>(entityName: entityName)
        fetchRequest.predicate = predicate
          do {
            let objects = try (managedContext?.fetch(fetchRequest))
            completion(.success(objects))
          } catch let error as NSError {
            completion(.failure(error))
          }
    }
    
    func save<T: NSManagedObject>(entityName: String, object: T) {
        guard let managedContext = self.managedContext else { return }
        managedContext.insert(object)
        saveContext()
     }
    
    
    func delete<T: NSManagedObject>(object: T?) {
        guard let managedContext = self.managedContext, let object = object else { return }
        managedContext.delete(object)
        saveContext()
    }
    
    func saveContext(){
        guard let context = self.managedContext else {return}
         do {
          try context.save()
         } catch let error as NSError {
          print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
}
