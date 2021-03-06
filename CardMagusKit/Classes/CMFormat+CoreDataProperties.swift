//
//  CMFormat+CoreDataProperties.swift
//  Pods
//
//  Created by Jovito Royeca on 15/04/2017.
//
//

import Foundation
import CoreData


extension CMFormat {

    @nonobjc open override class func fetchRequest() -> NSFetchRequest<NSFetchRequestResult> {
        return NSFetchRequest<CMFormat>(entityName: "CMFormat") as! NSFetchRequest<NSFetchRequestResult>
    }

    @NSManaged public var name: String?
    @NSManaged public var cardLegalities: NSSet?

}

// MARK: Generated accessors for cardLegalities
extension CMFormat {

    @objc(addCardLegalitiesObject:)
    @NSManaged public func addToCardLegalities(_ value: CMCardLegality)

    @objc(removeCardLegalitiesObject:)
    @NSManaged public func removeFromCardLegalities(_ value: CMCardLegality)

    @objc(addCardLegalities:)
    @NSManaged public func addToCardLegalities(_ values: NSSet)

    @objc(removeCardLegalities:)
    @NSManaged public func removeFromCardLegalities(_ values: NSSet)

}
