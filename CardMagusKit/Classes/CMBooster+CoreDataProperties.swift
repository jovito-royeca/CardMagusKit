//
//  CMBooster+CoreDataProperties.swift
//  
//
//  Created by Jovito Royeca on 12/04/2017.
//
//

import Foundation
import CoreData


extension CMBooster {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CMBooster> {
        return NSFetchRequest<CMBooster>(entityName: "CMBooster")
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
