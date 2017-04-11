//
//  CMLegality+CoreDataProperties.swift
//  
//
//  Created by Jovito Royeca on 11/04/2017.
//
//

import Foundation
import CoreData


extension CMLegality {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CMLegality> {
        return NSFetchRequest<CMLegality>(entityName: "CMLegality")
    }

    @NSManaged public var name: String?
    @NSManaged public var cardLegalities: NSSet?

}

// MARK: Generated accessors for cardLegalities
extension CMLegality {

    @objc(addCardLegalitiesObject:)
    @NSManaged public func addToCardLegalities(_ value: CMCardLegality)

    @objc(removeCardLegalitiesObject:)
    @NSManaged public func removeFromCardLegalities(_ value: CMCardLegality)

    @objc(addCardLegalities:)
    @NSManaged public func addToCardLegalities(_ values: NSSet)

    @objc(removeCardLegalities:)
    @NSManaged public func removeFromCardLegalities(_ values: NSSet)

}