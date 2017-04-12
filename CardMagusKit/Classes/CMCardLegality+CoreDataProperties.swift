//
//  CMCardLegality+CoreDataProperties.swift
//  
//
//  Created by Jovito Royeca on 12/04/2017.
//
//

import Foundation
import CoreData


extension CMCardLegality {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CMCardLegality> {
        return NSFetchRequest<CMCardLegality>(entityName: "CMCardLegality")
    }

    @NSManaged public var card: CMCard?
    @NSManaged public var format: CMFormat?
    @NSManaged public var legality: CMLegality?

}
