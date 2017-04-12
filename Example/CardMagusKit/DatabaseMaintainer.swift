//
//  DatabaseMaintainer.swift
//  CardMagusKit
//
//  Created by Jovito Royeca on 12/04/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import CardMagusKit
import DATAStack
import Sync

class DatabaseMaintainer: NSObject {
    // MARK: - Shared Instance
    public static let sharedInstance = DatabaseMaintainer()

    public func json2CoreData() {
        if let path = Bundle.main.path(forResource: "AllSetsArray-x", ofType: "json", inDirectory: "data") {
            if FileManager.default.fileExists(atPath: path) {
                let data = try! Data(contentsOf: URL(fileURLWithPath: path))
                let notifName = NSNotification.Name.NSManagedObjectContextObjectsDidChange
                
                if let dictionary = try! JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [[String: Any]] {
                    setupDataStack()
                    
                    CardMagus.sharedInstance.dataStack?.performInNewBackgroundContext { backgroundContext in
                        NotificationCenter.default.addObserver(self, selector: #selector(DatabaseMaintainer.changeNotification(_:)), name: notifName, object: backgroundContext)
                        Sync.changes(dictionary,
                                     inEntityNamed: "CMSet",
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
    }
    
    public func updateDatabase() {
        let request:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "CMSet")
        var sets:[CMSet]?
        sets = try! CardMagus.sharedInstance.dataStack?.mainContext.fetch(request) as? [CMSet]
        
//        if let
        
    }
    
    // MARK: private methods
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
    
    func setupDataStack() {
        guard let bundleURL = Bundle(for: CardMagus.self).url(forResource: "CardMagusKit", withExtension: "bundle") else { return }
        guard let frameworkBundle = Bundle(url: bundleURL) else { return }
        guard let momURL = frameworkBundle.url(forResource: "Card Magus Model", withExtension: "momd") else { return }
        guard let objectModel = NSManagedObjectModel(contentsOf: momURL) else { return }
        let dataStack = DATAStack(model: objectModel, storeType: .sqLite)
        
        CardMagus.sharedInstance.dataStack = dataStack
    }
}
