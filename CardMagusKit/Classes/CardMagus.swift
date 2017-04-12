//
//  CardMagus.swift
//  CardMagusKit
//
//  Created by Jovito Royeca on 11/04/2017.
//  Copyright © 2017 Jovito Royeca. All rights reserved.
//

import UIKit
import DATAStack
import Sync

@objc(CardMagus)
public class CardMagus: NSObject {
    // MARK: - Shared Instance
    public static let sharedInstance = CardMagus()
    
    // MARK: Variables
//    guard let bundleURL = NSBundle(forClass: FrameworkClass.self).URLForResource("myFramework", withExtension: "bundle") else { throw Error }
//    guard let frameworkBundle = NSBundle(URL: bundleURL) else { throw Error }
//    guard let momURL = frameworkBundle.URLForResource("Database", withExtension: "momd") else { throw Error }
//    public let dataStack: DATAStack = DATAStack(modelName: "Card Magus Model", bundle: Bundle(for: CardMagus.self), storeType: .sqLite)
    
    fileprivate var _dataStack:DATAStack?
    public var dataStack:DATAStack? {
        get {
            return _dataStack
        }
        set (newValue) {
            _dataStack = newValue
        }
    }
}
