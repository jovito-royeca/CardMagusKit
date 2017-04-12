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
    
    // MARK: Variables
//    guard let bundleURL = NSBundle(forClass: FrameworkClass.self).URLForResource("myFramework", withExtension: "bundle") else { throw Error }
//    guard let frameworkBundle = NSBundle(URL: bundleURL) else { throw Error }
//    guard let momURL = frameworkBundle.URLForResource("Database", withExtension: "momd") else { throw Error }
//    public let dataStack: DATAStack = DATAStack(modelName: "Card Magus Model", bundle: Bundle(for: CardMagus.self), storeType: .sqLite)
    
    fileprivate var _dataStack:DATAStack?
    open var dataStack:DATAStack? {
        get {
            return _dataStack
        }
        set (newValue) {
            _dataStack = newValue
        }
    }
    
    open func findOrCreateObject(entityName: String, objectFinder: [String: AnyObject]) -> NSManagedObject? {
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
