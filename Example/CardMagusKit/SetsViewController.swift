//
//  SetsViewController.swift
//  CardMagusKit
//
//  Created by Jovito Royeca on 15/04/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import CardMagusKit
import DATASource

class SetsViewController: UIViewController {

    // MARK: Variables
    var dataSource: DATASource?
    
    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        dataSource = getDataSource(nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSet" {
            if let dest = segue.destination as? SetViewController,
                let set = sender as? CMSet {
                
                dest.set = set
                dest.title = set.name
            }
        }
    }
    
    // MARK: Custom methods
    func getDataSource(_ fetchRequest: NSFetchRequest<NSFetchRequestResult>?) -> DATASource? {
        var request:NSFetchRequest<NSFetchRequestResult>?
        
        if let fetchRequest = fetchRequest {
            request = fetchRequest
        } else {
            request = NSFetchRequest(entityName: "CMSet")
            request!.sortDescriptors = [NSSortDescriptor(key: "releaseDate", ascending: false)]
        }
        
        let dataSource = DATASource(tableView: tableView, cellIdentifier: "Cell", fetchRequest: request!, mainContext: CardMagus.sharedInstance.dataStack!.mainContext, configuration: { cell, item, indexPath in
            if let set = item as? CMSet {
            
                if let image = CardMagus.sharedInstance.imageFromCache("/images/set/\(set.code!)/C/32.png") {
                    cell.imageView?.image = image
                } else if let image = CardMagus.sharedInstance.imageFromCache("/images/set/\(set.code!)/R/32.png") {
                    cell.imageView?.image = image
                } else if let image = CardMagus.sharedInstance.imageFromCache("/images/other/blank/32.png") {
                    cell.imageView?.image = image
                }
                
                cell.textLabel?.text = set.name
                cell.detailTextLabel?.text = "\(set.cards!.allObjects.count) cards / Released: \(set.releaseDate!)"
            }
        })
        
        return dataSource
    }
}

// MARK: UITableViewDelegate
extension SetsViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sets = dataSource!.all()
        let set = sets[indexPath.row]
        performSegue(withIdentifier: "showSet", sender: set)
    }
}
