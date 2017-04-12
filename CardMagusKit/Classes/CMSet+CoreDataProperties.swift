//
//  CMSet+CoreDataProperties.swift
//  
//
//  Created by Jovito Royeca on 12/04/2017.
//
//

import Foundation
import CoreData


extension CMSet {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CMSet> {
        return NSFetchRequest<CMSet>(entityName: "CMSet")
    }

    @NSManaged public var block: String?
    @NSManaged public var booster: NSData?
    @NSManaged public var border: String?
    @NSManaged public var code: String?
    @NSManaged public var gathererCode: String?
    @NSManaged public var magicCardsInfoCode: String?
    @NSManaged public var name: String?
    @NSManaged public var oldCode: String?
    @NSManaged public var onlineOnly: Bool
    @NSManaged public var releaseDate: String?
    @NSManaged public var type: String?
    @NSManaged public var cards: NSSet?
    @NSManaged public var printings_: CMCard?
    @NSManaged public var type_: CMSetType?
    @NSManaged public var block_: CMBlock?
    @NSManaged public var border_: CMBorder?
    @NSManaged public var booster_: CMBooster?

}

// MARK: Generated accessors for cards
extension CMSet {

    @objc(addCardsObject:)
    @NSManaged public func addToCards(_ value: CMCard)

    @objc(removeCardsObject:)
    @NSManaged public func removeFromCards(_ value: CMCard)

    @objc(addCards:)
    @NSManaged public func addToCards(_ values: NSSet)

    @objc(removeCards:)
    @NSManaged public func removeFromCards(_ values: NSSet)

}
