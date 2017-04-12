//
//  CardMagus.swift
//  CardMagusKit
//
//  Created by Jovito Royeca on 11/04/2017.
//  Copyright © 2017 Jovito Royeca. All rights reserved.
//

import UIKit
import DATAStack
import Sync

class CardMagus: NSObject {
    // MARK: - Shared Instance
    static let sharedInstance = CardMagus()
    
    // MARK: Variables
    let dataStack: DATAStack = DATAStack(modelName: "Card Magus Model")
    
    func json2CoreData() {
        let bundle = Bundle(for: CardMagus.self)
        
        if let path = bundle.path(forResource: "AllSets-x", ofType: "json", inDirectory: "data") {
            if FileManager.default.fileExists(atPath: path) {
                let data = try! Data(contentsOf: URL(fileURLWithPath: path))
                let notifName = NSNotification.Name.NSManagedObjectContextObjectsDidChange
                
                if let dictionary = try! JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    dataStack.performInNewBackgroundContext { backgroundContext in
                        NotificationCenter.default.addObserver(self, selector: #selector(CardMagus.changeNotification(_:)), name: notifName, object: backgroundContext)
                        Sync.changes([dictionary],
                                     inEntityNamed: "Set",
                                     predicate: nil,
                                     parent: nil,
                                     parentRelationship: nil,
                                     inContext: backgroundContext,
                                     operations: [.insert, .update],
                                     completion:  { error in
                                        NotificationCenter.default.removeObserver(self, name:notifName, object: nil)
                                        
                        })
                    }
                }
            }
        }
        
//        do {
//            let request:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "CMSet")
//            var sets:[CMSet]?
//            sets = try dataStack.mainContext.fetch(request) as? [CMSet]
//            print("sets=\(sets!.count)")
//        } catch { }        
    }
    
    func changeNotification(_ notification: Notification) {
        if let updatedObjects = notification.userInfo?[NSUpdatedObjectsKey] {
            print("updatedObjects: \((updatedObjects as AnyObject).count!)")
        }
        if let deletedObjects = notification.userInfo?[NSDeletedObjectsKey] {
            print("deletedObjects: \((deletedObjects as AnyObject).count!)")
        }
        if let insertedObjects = notification.userInfo?[NSInsertedObjectsKey] {
            print("insertedObjects: \((insertedObjects as AnyObject).count!)")
        }
    }
}
