//
//  DatabaseMaintainer.swift
//  CardMagusKit
//
//  Created by Jovito Royeca on 12/04/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import CardMagusKit
import DATAStack
import Sync

class DatabaseMaintainer: NSObject {
    // MARK: - Shared Instance
    open static let sharedInstance = DatabaseMaintainer()

    open func json2CoreData() {
        let dateStart = Date()
        
        if let path = Bundle.main.path(forResource: "AllSetsArray-x", ofType: "json", inDirectory: "data") {
            if FileManager.default.fileExists(atPath: path) {
                let data = try! Data(contentsOf: URL(fileURLWithPath: path))
                let notifName = NSNotification.Name.NSManagedObjectContextObjectsDidChange
                
                if let dictionary = try! JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [[String: Any]] {
                    setupDataStack()
                    
                    CardMagus.sharedInstance.dataStack?.performInNewBackgroundContext { backgroundContext in
                        NotificationCenter.default.addObserver(self, selector: #selector(DatabaseMaintainer.changeNotification(_:)), name: notifName, object: backgroundContext)
                        Sync.changes(dictionary,
                                     inEntityNamed: "CMSet",
                                     predicate: nil,
                                     parent: nil,
                                     parentRelationship: nil,
                                     inContext: backgroundContext,
                                     operations: [.insert, .update],
                                     completion:  { error in
                                        NotificationCenter.default.removeObserver(self, name:notifName, object: nil)
                                        
                                        print("Updating Sets...")
                                        self.updateSets()
                                        print("Updating Cards...")
                                        self.updateCards()
                                        print("Updating Extra Info...")
                                        self.updateExtraInfo()
                                        let dateEnd = Date()
                                        let timeDifference = dateEnd.timeIntervalSince(dateStart)
                                        print("Time Elapsed: \(dateStart) - \(dateEnd) : \(timeDifference)")
                                        print("docsPath = \(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])")
                        })
                    }
                }
            }
        }
    }
    
    public func updateSets() {
        let request:NSFetchRequest<CMSet> = CMSet.fetchRequest() as! NSFetchRequest<CMSet>
        var tcgPlayerCodeDict:[String: String]?
        
        if let path = Bundle.main.path(forResource: "TCGPlayerCode", ofType: "plist", inDirectory: "data") {
            if FileManager.default.fileExists(atPath: path) {
                let data = try! Data(contentsOf: URL(fileURLWithPath: path))
                
                tcgPlayerCodeDict = try! PropertyListSerialization.propertyList(from: data, options: [], format: nil) as? [String: String]
            }
        }
        
        if let sets = try! CardMagus.sharedInstance.dataStack?.mainContext.fetch(request) {
            for set in sets {

                // border
                if let border = set.border {
                    let objectFinder = ["name": border] as [String: AnyObject]
                    if let object = CardMagus.sharedInstance.findOrCreateObject("CMBorder", objectFinder: objectFinder) as? CMBorder {
                        object.name = border
                        set.border = nil
                        set.border_ = object
                    }
                }
                
                // type
                if let type = set.type {
                    let objectFinder = ["name": type] as [String: AnyObject]
                    if let object = CardMagus.sharedInstance.findOrCreateObject("CMSetType", objectFinder: objectFinder) as? CMSetType {
                        object.name = type
                        set.type = nil
                        set.type_ = object
                    }
                }
                
                // block
                if let block = set.block {
                    let objectFinder = ["name": block] as [String: AnyObject]
                    if let object = CardMagus.sharedInstance.findOrCreateObject("CMBlock", objectFinder: objectFinder) as? CMBlock {
                        object.name = block
                        set.block = nil
                        set.block_ = object
                    }
                }
                
                // booster
                if let booster = set.booster {
                    let booster_ = set.mutableSetValue(forKey: "booster_")
                    
                    if let boosterArray = NSKeyedUnarchiver.unarchiveObject(with: booster as Data) as? [String] {
                        for booster in boosterArray {
                            let objectFinder = ["name": booster] as [String: AnyObject]
                            if let object = CardMagus.sharedInstance.findOrCreateObject("CMBooster", objectFinder: objectFinder) as? CMBooster {
                                object.name = booster
                                booster_.add(object)
                            }
                        }
                    }
                    
                    set.booster = nil
                }
                
                // tcgPlayerCode
                if let tcgPlayerCodeDict = tcgPlayerCodeDict,
                    let name = set.name {
                    set.tcgPlayerCode = tcgPlayerCodeDict[name]
                }

                try! CardMagus.sharedInstance.dataStack?.mainContext.save()
            }
        }
    }
    
    public func updateCards() {
        let request:NSFetchRequest<CMCard> = CMCard.fetchRequest() as! NSFetchRequest<CMCard>
        
        if let cards = try! CardMagus.sharedInstance.dataStack?.mainContext.fetch(request) {
            for card in cards {
            
                // layout
                if let layout = card.layout {
                    let objectFinder = ["name": layout] as [String: AnyObject]
                    if let object = CardMagus.sharedInstance.findOrCreateObject("CMLayout", objectFinder: objectFinder) as? CMLayout {
                        object.name = layout
                        card.layout = nil
                        card.layout_ = object
                    }
                }
                
                // colors
                if let colors = card.colors {
                    let colors_ = card.mutableSetValue(forKey: "colors_")
                    
                    if let colorsArray = NSKeyedUnarchiver.unarchiveObject(with: colors as Data) as? [String] {
                        for color in colorsArray {
                            let objectFinder = ["name": color] as [String: AnyObject]
                            if let object = CardMagus.sharedInstance.findOrCreateObject("CMColor", objectFinder: objectFinder) as? CMColor {
                                object.name = color
                                let index = color.index(color.startIndex, offsetBy: 1)
                                var prefix = color.substring(to: index)
                                if color == "Blue" {
                                    prefix = "U"
                                }
                                object.symbol = prefix
                                
                                
                                colors_.add(object)
                            }
                        }
                    }
                    
                    card.colors = nil
                }
                
                // colorIdentity
                if let colorIdentity = card.colorIdentity {
                    let colorIdentities_ = card.mutableSetValue(forKey: "colorIdentities_")
                        if let coloridentityArray = NSKeyedUnarchiver.unarchiveObject(with: colorIdentity as Data) as? [String] {
                        
                        for symbol in coloridentityArray {
                            let objectFinder = ["symbol": symbol] as [String: AnyObject]
                            if let object = CardMagus.sharedInstance.findOrCreateObject("CMColor", objectFinder: objectFinder) as? CMColor {
                                object.symbol = symbol
                                colorIdentities_.add(object)
                            }
                        }
                    }
                    
                    card.colorIdentity = nil
                }
                
                // type
                if let type = card.type {
                    let objectFinder = ["name": type] as [String: AnyObject]
                    if let object = CardMagus.sharedInstance.findOrCreateObject("CMCardType", objectFinder: objectFinder) as? CMCardType {
                        object.name = type
                        card.type = nil
                        card.type_ = object
                    }
                }
                
                // supertypes
                if let supertypes = card.supertypes {
                    let supertypes_ = card.mutableSetValue(forKey: "supertypes_")
                    
                    if let supertypesArray = NSKeyedUnarchiver.unarchiveObject(with: supertypes as Data) as? [String] {
                        for supertype in supertypesArray {
                            let objectFinder = ["name": supertype] as [String: AnyObject]
                            if let object = CardMagus.sharedInstance.findOrCreateObject("CMCardType", objectFinder: objectFinder) as? CMCardType {
                                object.name = supertype
                                supertypes_.add(object)
                            }
                        }
                    }
                    
                    card.supertypes = nil
                }
                
                // types
                if let types = card.types {
                    let types_ = card.mutableSetValue(forKey: "types_")
                    
                    if let typesArray = NSKeyedUnarchiver.unarchiveObject(with: types as Data) as? [String] {
                        for type in typesArray {
                            let objectFinder = ["name": type] as [String: AnyObject]
                            if let object = CardMagus.sharedInstance.findOrCreateObject("CMCardType", objectFinder: objectFinder) as? CMCardType {
                                object.name = type
                                types_.add(object)
                            }
                        }
                    }
                    
                    card.types = nil
                }
                
                // subtypes
                if let subtypes = card.subtypes {
                    let subtypes_ = card.mutableSetValue(forKey: "subtypes_")
                    
                    if let subtypesArray = NSKeyedUnarchiver.unarchiveObject(with: subtypes as Data) as? [String] {
                        for subtype in subtypesArray {
                            let objectFinder = ["name": subtype] as [String: AnyObject]
                            if let object = CardMagus.sharedInstance.findOrCreateObject("CMCardType", objectFinder: objectFinder) as? CMCardType {
                                object.name = subtype
                                subtypes_.add(object)
                            }
                        }
                    }
                    
                    card.subtypes = nil
                }
                
                // rarity
                if let rarity = card.rarity {
                    let objectFinder = ["name": rarity] as [String: AnyObject]
                    if let object = CardMagus.sharedInstance.findOrCreateObject("CMRarity", objectFinder: objectFinder) as? CMRarity {
                        object.name = rarity
                        card.rarity = nil
                        card.rarity_ = object
                    }
                }
                
                // artist
                if let artist = card.artist {
                    let objectFinder = ["name": artist] as [String: AnyObject]
                    if let object = CardMagus.sharedInstance.findOrCreateObject("CMArtist", objectFinder: objectFinder) as? CMArtist {
                        object.name = artist
                        card.artist = nil
                        card.artist_ = object
                    }
                }
                
                // watermark
                if let watermark = card.watermark {
                    let objectFinder = ["name": watermark] as [String: AnyObject]
                    if let object = CardMagus.sharedInstance.findOrCreateObject("CMWatermark", objectFinder: objectFinder) as? CMWatermark {
                        object.name = watermark
                        card.watermark = nil
                        card.watermark_ = object
                    }
                }
                
                // border
                if let border = card.border {
                    let objectFinder = ["name": border] as [String: AnyObject]
                    if let object = CardMagus.sharedInstance.findOrCreateObject("CMBorder", objectFinder: objectFinder) as? CMBorder {
                        object.name = border
                        card.border = nil
                        card.border_ = object
                    }
                }
                
                try! CardMagus.sharedInstance.dataStack?.mainContext.save()
            }
        }
    }

    func updateExtraInfo() {

        let request:NSFetchRequest<CMCard> = CMCard.fetchRequest() as! NSFetchRequest<CMCard>
        
        if let cards = try! CardMagus.sharedInstance.dataStack?.mainContext.fetch(request) {
            for card in cards {
                let code = card.set?.code ?? ""
                print("\(card.name!) - (\(code))")
        
                // variations
                if let variations = card.variations {
                    let variations_ = card.mutableSetValue(forKey: "variations_")
                    
                    if let variationsArray = NSKeyedUnarchiver.unarchiveObject(with: variations as Data) as? [Int] {
                        for variation in variationsArray {
                            let objectFinder = ["multiverseid": variation] as [String: AnyObject]
                            if let object = CardMagus.sharedInstance.findOrCreateObject("CMCard", objectFinder: objectFinder) as? CMCard {
                                variations_.add(object)
                            }
                        }
                    }
                    
                    card.variations = nil
                }
                
                // rulings
                if let rulings = card.rulings {
                    let rulings_ = card.mutableSetValue(forKey: "rulings_")
                    
                    if let rulingsArray = NSKeyedUnarchiver.unarchiveObject(with: rulings as Data) as? [[String: AnyObject]] {
                        for ruling in rulingsArray {
                            let objectFinder = ["date": ruling["date"] as? String,
                                                "text": ruling["text"] as? String,
                                                "card.id": card.id!] as [String: AnyObject]
                            if let object = CardMagus.sharedInstance.findOrCreateObject("CMRuling", objectFinder: objectFinder) as? CMRuling {
                                object.date = ruling["date"] as? String
                                object.text = ruling["text"] as? String
                                object.card = card
                                object.id = Int64("\(card.id!)_\(object.date!)_\(object.text!)".hashValue)
                                rulings_.add(object)
                            }
                        }
                    }
                    
                    card.rulings = nil
                }
                
                // foreignNames
                if let foreignNames = card.foreignNames {
                    let foreignNames_ = card.mutableSetValue(forKey: "foreignNames_")
                    
                    if let foreignNamesArray = NSKeyedUnarchiver.unarchiveObject(with: foreignNames as Data) as? [[String: AnyObject]] {
                        for foreignName in foreignNamesArray {
                            var objectFinder = ["name": foreignName["language"]] as [String: AnyObject]
                            var language:CMLanguage?
                            if let object = CardMagus.sharedInstance.findOrCreateObject("CMLanguage", objectFinder: objectFinder) as? CMLanguage {
                                language = object
                                language!.name = foreignName["language"] as? String
                            }
                            
                            objectFinder = ["name": foreignName["name"],
                                            "multiverseid": foreignName["multiverseid"],
                                            "language": language!] as [String: AnyObject]
                            if let object = CardMagus.sharedInstance.findOrCreateObject("CMForeignName", objectFinder: objectFinder) as? CMForeignName {
                                object.name = foreignName["name"] as? String
                                object.language = language
                                object.card = card
                                
                                var id = "\(card.id!)_\(object.name!)_\(object.language!.name!)"
                                if let multiverseid = foreignName["multiverseid"] as? String {
                                    object.multiverseid = Int64(multiverseid)!
                                    id += "_\(multiverseid)"
                                }
                                object.id = Int64(id.hashValue)
                                foreignNames_.add(object)
                            }
                        }
                    }
                    
                    card.foreignNames = nil
                }

                // printings
                if let printings = card.printings {
                    let printings_ = card.mutableSetValue(forKey: "printings_")
                    
                    if let printingsArray = NSKeyedUnarchiver.unarchiveObject(with: printings as Data) as? [String] {
                        for printing in printingsArray {
                            let objectFinder = ["code": printing] as [String: AnyObject]
                            if let object = CardMagus.sharedInstance.findOrCreateObject("CMSet", objectFinder: objectFinder) as? CMSet {
                                printings_.add(object)
                            }
                        }
                    }
                    
                    card.printings = nil
                }
                
                // legalities
                if let legalities = card.legalities {
                    let legalities_ = card.mutableSetValue(forKey: "cardLegalities_")
                    
                    if let legalitiesArray = NSKeyedUnarchiver.unarchiveObject(with: legalities as Data) as? [[String: AnyObject]] {
                        for legality in legalitiesArray {
                            var format:CMFormat?
                            var legal:CMLegality?
                            
                            var objectFinder = ["name": legality["format"]] as [String: AnyObject]
                            if let object = CardMagus.sharedInstance.findOrCreateObject("CMFormat", objectFinder: objectFinder) as? CMFormat {
                                format = object
                                format!.name = legality["format"] as? String
                            }
                            
                            objectFinder = ["name": legality["legality"]] as [String: AnyObject]
                            if let object = CardMagus.sharedInstance.findOrCreateObject("CMLegality", objectFinder: objectFinder) as? CMLegality {
                                legal = object
                                legal!.name = legality["legality"] as? String
                            }
                            
                            objectFinder = ["format": format!,
                                            "legality": legal!,
                                            "card": card] as [String: AnyObject]
                            if let object = CardMagus.sharedInstance.findOrCreateObject("CMCardLegality", objectFinder: objectFinder) as? CMCardLegality {
                                object.format = format
                                object.legality = legal
                                object.card = card
                                object.id = Int64("\(card.id!)_\(object.format!.name!)_\(object.legality!.name!)".hashValue)
                                legalities_.add(object)
                            }
                        }
                    }
                    
                    card.legalities = nil
                }
            }
        }
    }
    
    // MARK: private methods
    func changeNotification(_ notification: Notification) {
        if let updatedObjects = notification.userInfo?[NSUpdatedObjectsKey] {
            print("updatedObjects: \((updatedObjects as AnyObject).count!)")
        }
        if let deletedObjects = notification.userInfo?[NSDeletedObjectsKey] {
            print("deletedObjects: \((deletedObjects as AnyObject).count!)")
        }
        if let insertedObjects = notification.userInfo?[NSInsertedObjectsKey] {
            print("insertedObjects: \((insertedObjects as AnyObject).count!)")
        }
    }
    
    func setupDataStack() {
        guard let bundleURL = Bundle(for: CardMagus.self).url(forResource: "CardMagusKit", withExtension: "bundle") else { return }
        guard let frameworkBundle = Bundle(url: bundleURL) else { return }
        guard let momURL = frameworkBundle.url(forResource: "Card Magus", withExtension: "momd") else { return }
        guard let objectModel = NSManagedObjectModel(contentsOf: momURL) else { return }
        let dataStack = DATAStack(model: objectModel, storeType: .sqLite)
        
        CardMagus.sharedInstance.dataStack = dataStack
    }
}
