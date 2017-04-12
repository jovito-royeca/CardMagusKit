//
//  CMCard+CoreDataProperties.swift
//  Pods
//
//  Created by Jovito Royeca on 12/04/2017.
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
    @NSManaged public var artist: String?
    @NSManaged public var artist_: CMArtist?
    @NSManaged public var border_: CMBorder?
    @NSManaged public var cardLegalities_: NSSet?
    @NSManaged public var foreignNames_: NSSet?
    @NSManaged public var set: CMSet?
    @NSManaged public var layout_: CMLayout?
    @NSManaged public var variations_: NSSet?
    @NSManaged public var names_: NSSet?
    @NSManaged public var colors_: NSSet?
    @NSManaged public var colorIdentities_: NSSet?
    @NSManaged public var type_: CMCardType?
    @NSManaged public var subtypes_: NSSet?
    @NSManaged public var supertypes_: NSSet?
    @NSManaged public var types_: NSSet?
    @NSManaged public var rarity_: CMRarity?
    @NSManaged public var watermark_: CMWatermark?

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

// MARK: Generated accessors for variations_
extension CMCard {

    @objc(addVariations_Object:)
    @NSManaged public func addToVariations_(_ value: CMCard)

    @objc(removeVariations_Object:)
    @NSManaged public func removeFromVariations_(_ value: CMCard)

    @objc(addVariations_:)
    @NSManaged public func addToVariations_(_ values: NSSet)

    @objc(removeVariations_:)
    @NSManaged public func removeFromVariations_(_ values: NSSet)

}

// MARK: Generated accessors for names_
extension CMCard {

    @objc(addNames_Object:)
    @NSManaged public func addToNames_(_ value: CMCard)

    @objc(removeNames_Object:)
    @NSManaged public func removeFromNames_(_ value: CMCard)

    @objc(addNames_:)
    @NSManaged public func addToNames_(_ values: NSSet)

    @objc(removeNames_:)
    @NSManaged public func removeFromNames_(_ values: NSSet)

}

// MARK: Generated accessors for colors_
extension CMCard {

    @objc(addColors_Object:)
    @NSManaged public func addToColors_(_ value: CMCard)

    @objc(removeColors_Object:)
    @NSManaged public func removeFromColors_(_ value: CMCard)

    @objc(addColors_:)
    @NSManaged public func addToColors_(_ values: NSSet)

    @objc(removeColors_:)
    @NSManaged public func removeFromColors_(_ values: NSSet)

}

// MARK: Generated accessors for colorIdentities_
extension CMCard {

    @objc(addColorIdentities_Object:)
    @NSManaged public func addToColorIdentities_(_ value: CMColor)

    @objc(removeColorIdentities_Object:)
    @NSManaged public func removeFromColorIdentities_(_ value: CMColor)

    @objc(addColorIdentities_:)
    @NSManaged public func addToColorIdentities_(_ values: NSSet)

    @objc(removeColorIdentities_:)
    @NSManaged public func removeFromColorIdentities_(_ values: NSSet)

}

// MARK: Generated accessors for subtypes_
extension CMCard {

    @objc(addSubtypes_Object:)
    @NSManaged public func addToSubtypes_(_ value: CMCardType)

    @objc(removeSubtypes_Object:)
    @NSManaged public func removeFromSubtypes_(_ value: CMCardType)

    @objc(addSubtypes_:)
    @NSManaged public func addToSubtypes_(_ values: NSSet)

    @objc(removeSubtypes_:)
    @NSManaged public func removeFromSubtypes_(_ values: NSSet)

}

// MARK: Generated accessors for supertypes_
extension CMCard {

    @objc(addSupertypes_Object:)
    @NSManaged public func addToSupertypes_(_ value: CMCardType)

    @objc(removeSupertypes_Object:)
    @NSManaged public func removeFromSupertypes_(_ value: CMCardType)

    @objc(addSupertypes_:)
    @NSManaged public func addToSupertypes_(_ values: NSSet)

    @objc(removeSupertypes_:)
    @NSManaged public func removeFromSupertypes_(_ values: NSSet)

}

// MARK: Generated accessors for types_
extension CMCard {

    @objc(addTypes_Object:)
    @NSManaged public func addToTypes_(_ value: CMCardType)

    @objc(removeTypes_Object:)
    @NSManaged public func removeFromTypes_(_ value: CMCardType)

    @objc(addTypes_:)
    @NSManaged public func addToTypes_(_ values: NSSet)

    @objc(removeTypes_:)
    @NSManaged public func removeFromTypes_(_ values: NSSet)

}
