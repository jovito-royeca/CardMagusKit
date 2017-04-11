//
//  CMCard+CoreDataProperties.swift
//  
//
//  Created by Jovito Royeca on 11/04/2017.
//
//

import Foundation
import CoreData


extension CMCard {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CMCard> {
        return NSFetchRequest<CMCard>(entityName: "CMCard")
    }

    @NSManaged public var border: String?
    @NSManaged public var cmc: Double
    @NSManaged public var coloridentity: NSData?
    @NSManaged public var colors: NSData?
    @NSManaged public var flavor: String?
    @NSManaged public var foreignNames: NSData?
    @NSManaged public var hand: Int32
    @NSManaged public var id: String?
    @NSManaged public var imageName: String?
    @NSManaged public var layout: String?
    @NSManaged public var legalities: NSData?
    @NSManaged public var life: Int32
    @NSManaged public var loyalty: Int32
    @NSManaged public var manaCost: String?
    @NSManaged public var mciNumber: Int32
    @NSManaged public var multiverseid: Int64
    @NSManaged public var name: String?
    @NSManaged public var names: NSData?
    @NSManaged public var number: String?
    @NSManaged public var originalText: String?
    @NSManaged public var originalType: String?
    @NSManaged public var power: String?
    @NSManaged public var printings: NSData?
    @NSManaged public var rarity: String?
    @NSManaged public var releaseDate: String?
    @NSManaged public var reserved: Bool
    @NSManaged public var rulings: NSData?
    @NSManaged public var source: String?
    @NSManaged public var starter: Bool
    @NSManaged public var subtypes: NSData?
    @NSManaged public var supertypes: NSData?
    @NSManaged public var text: String?
    @NSManaged public var timeshifted: Bool
    @NSManaged public var toughness: String?
    @NSManaged public var type: String?
    @NSManaged public var types: NSData?
    @NSManaged public var variations: NSData?
    @NSManaged public var watermark: String?
    @NSManaged public var artist: CMArtist?
    @NSManaged public var cardLegalities_: NSSet?
    @NSManaged public var foreignNames_: NSSet?
    @NSManaged public var printings_: NSSet?
    @NSManaged public var set: CMSet?

}

// MARK: Generated accessors for cardLegalities_
extension CMCard {

    @objc(addCardLegalities_Object:)
    @NSManaged public func addToCardLegalities_(_ value: CMCardLegality)

    @objc(removeCardLegalities_Object:)
    @NSManaged public func removeFromCardLegalities_(_ value: CMCardLegality)

    @objc(addCardLegalities_:)
    @NSManaged public func addToCardLegalities_(_ values: NSSet)

    @objc(removeCardLegalities_:)
    @NSManaged public func removeFromCardLegalities_(_ values: NSSet)

}

// MARK: Generated accessors for foreignNames_
extension CMCard {

    @objc(addForeignNames_Object:)
    @NSManaged public func addToForeignNames_(_ value: CMForeignName)

    @objc(removeForeignNames_Object:)
    @NSManaged public func removeFromForeignNames_(_ value: CMForeignName)

    @objc(addForeignNames_:)
    @NSManaged public func addToForeignNames_(_ values: NSSet)

    @objc(removeForeignNames_:)
    @NSManaged public func removeFromForeignNames_(_ values: NSSet)

}

// MARK: Generated accessors for printings_
extension CMCard {

    @objc(addPrintings_Object:)
    @NSManaged public func addToPrintings_(_ value: CMSet)

    @objc(removePrintings_Object:)
    @NSManaged public func removeFromPrintings_(_ value: CMSet)

    @objc(addPrintings_:)
    @NSManaged public func addToPrintings_(_ values: NSSet)

    @objc(removePrintings_:)
    @NSManaged public func removeFromPrintings_(_ values: NSSet)

}
