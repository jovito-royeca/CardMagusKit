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

@objc(CardMagus)
open class CardMagus: NSObject {
    // MARK: - Shared Instance
    open static let sharedInstance = CardMagus()
    
    fileprivate var _dataStack:DATAStack?
    open var dataStack:DATAStack? {
        get {
            return _dataStack
        }
        set (newValue) {
            _dataStack = newValue
        }
    }
    
    open func findOrCreateObject(_ entityName: String, objectFinder: [String: AnyObject]) -> NSManagedObject? {
        var object:NSManagedObject?
        var predicate:NSPredicate?
        
        for (key,value) in objectFinder {
            if predicate != nil {
                predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicate!, NSPredicate(format: "%K == %@", key, value as! NSObject)])
            } else {
                predicate = NSPredicate(format: "%K == %@", key, value as! NSObject)
            }
        }

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.predicate = predicate
        
        if let m = try! dataStack?.mainContext.fetch(fetchRequest).first as? NSManagedObject{
            object = m
        } else  {
            if let desc = NSEntityDescription.entity(forEntityName: entityName, in: dataStack!.mainContext) {
                object = NSManagedObject(entity: desc, insertInto: dataStack?.mainContext)
                try! dataStack?.mainContext.save()
            }
        }
        
        return object
    }
}
