//
//  CMSet+CoreDataProperties.swift
//  Pods
//
//  Created by Jovito Royeca on 12/04/2017.
//
//

import Foundation
import CoreData


extension CMSet {

    @nonobjc open override class func fetchRequest() -> NSFetchRequest<NSFetchRequestResult> {
        return NSFetchRequest<CMSet>(entityName: "CMSet") as! NSFetchRequest<NSFetchRequestResult>
    }

    @NSManaged public var block: String?
    @NSManaged public var booster: Data?
    @NSManaged public var border: String?
    @NSManaged public var code: String?
    @NSManaged public var gathererCode: String?
    @NSManaged public var magicCardsInfoCode: String?
    @NSManaged public var tcgPlayerCode: String?
    @NSManaged public var name: String?
    @NSManaged public var oldCode: String?
    @NSManaged public var onlineOnly: Bool
    @NSManaged public var releaseDate: String?
    @NSManaged public var type: String?
    @NSManaged public var block_: CMBlock?
    @NSManaged public var border_: CMBorder?
    @NSManaged public var cards: NSSet?
    @NSManaged public var booster_: NSSet?
    @NSManaged public var printings_: NSSet?
    @NSManaged public var type_: CMSetType?

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

// MARK: Generated accessors for printings_
extension CMSet {
    
    @objc(addPrintings_Object:)
    @NSManaged public func addToPrintings_(_ value: CMCard)
    
    @objc(removePrintings_Object:)
    @NSManaged public func removeFromPrintings_(_ value: CMCard)
    
    @objc(addPrintings_:)
    @NSManaged public func addToPrintings_(_ values: NSSet)
    
    @objc(removePrintings_:)
    @NSManaged public func removeFromPrintings_(_ values: NSSet)
    
}

// MARK: Generated accessors for booster_
extension CMSet {
    
    @objc(addBooster_Object:)
    @NSManaged public func addToBooster_(_ value: CMBooster)
    
    @objc(removeBooster_Object:)
    @NSManaged public func removeFromBooster_(_ value: CMBooster)
    
    @objc(addBooster:)
    @NSManaged public func addToBooster_(_ values: NSSet)
    
    @objc(removeBooster_:)
    @NSManaged public func removeFromBooster_(_ values: NSSet)
    
}

