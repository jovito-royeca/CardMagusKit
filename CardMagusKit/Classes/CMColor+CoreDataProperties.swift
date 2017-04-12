//
//  CMColor+CoreDataProperties.swift
//  Pods
//
//  Created by Jovito Royeca on 12/04/2017.
//
//

import Foundation
import CoreData


extension CMColor {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CMColor> {
        return NSFetchRequest<CMColor>(entityName: "CMColor")
    }

    @NSManaged public var name: String?
    @NSManaged public var symbol: String?
    @NSManaged public var cardColors: NSSet?
    @NSManaged public var cardIdentities: CMCard?

}

// MARK: Generated accessors for cardColors
extension CMColor {

    @objc(addCardColorsObject:)
    @NSManaged public func addToCardColors(_ value: CMCard)

    @objc(removeCardColorsObject:)
    @NSManaged public func removeFromCardColors(_ value: CMCard)

    @objc(addCardColors:)
    @NSManaged public func addToCardColors(_ values: NSSet)

    @objc(removeCardColors:)
    @NSManaged public func removeFromCardColors(_ values: NSSet)

}
