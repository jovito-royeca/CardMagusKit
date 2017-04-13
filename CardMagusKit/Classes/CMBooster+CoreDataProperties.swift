//
//  CMBooster+CoreDataProperties.swift
//  Pods
//
//  Created by Jovito Royeca on 12/04/2017.
//
//

import Foundation
import CoreData


extension CMBooster {

    @nonobjc open override class func fetchRequest() -> NSFetchRequest<NSFetchRequestResult> {
        return NSFetchRequest<CMBooster>(entityName: "CMBooster") as! NSFetchRequest<NSFetchRequestResult>
    }

    @NSManaged public var name: String?
    @NSManaged public var sets: NSSet?

}

// MARK: Generated accessors for sets
extension CMBooster {

    @objc(addSetsObject:)
    @NSManaged public func addToSets(_ value: CMSet)

    @objc(removeSetsObject:)
    @NSManaged public func removeFromSets(_ value: CMSet)

    @objc(addSets:)
    @NSManaged public func addToSets(_ values: NSSet)

    @objc(removeSets:)
    @NSManaged public func removeFromSets(_ values: NSSet)

}
