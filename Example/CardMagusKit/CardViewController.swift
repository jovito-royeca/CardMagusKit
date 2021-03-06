//
//  CardViewController.swift
//  CardMagusKit
//
//  Created by Jovito Royeca on 28/04/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import CardMagusKit

class CardViewController: UIViewController {

    // MARK: Variables
    var card:CMCard?
    
    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: overrides
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.register(CardMagus.sharedInstance.nibFromBundle("CardTableViewCell"), forCellReuseIdentifier: "CardCell")
    }

}

// MARK: UITableViewDataSource
extension CardViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell?
        
        switch indexPath.row {
        case 0:
            if let c = tableView.dequeueReusableCell(withIdentifier: "CardCell") as? CardTableViewCell {
                c.card = card
                c.updateDataDisplay()
                cell = c
            }
        case 1:
            if let c = tableView.dequeueReusableCell(withIdentifier: "ImageCell") {
                if let imageView = c.viewWithTag(100) as? UIImageView,
                    let card = card {
                    c.backgroundColor = UIColor(patternImage: CardMagus.sharedInstance.imageFromFramework("/images/Gray_Patterned_BG.jpg")!)
                    
                    if let cardImage = CardMagus.sharedInstance.cardImage(card) {
                        imageView.image = cardImage
                    } else {
                        imageView.image = CardMagus.sharedInstance.imageFromFramework("/images/cardback-hq.jpg")
                        CardMagus.sharedInstance.downloadCardImage(card, cropImage: true, completion: { (c: CMCard, image: UIImage?, croppedImage: UIImage?, error: NSError?) in
                            if error == nil {
                                UIView.transition(with: imageView,
                                                  duration: 1.0,
                                                  options: .transitionFlipFromRight,
                                                  animations: {
                                                    imageView.image = image
                                                },
                                                  completion: nil)
                            }
                        })
                    }

                }
                
                cell = c
            }
        default:
            ()
        }
        
        return cell!
    }
}

// MARK: UITableViewDelegate
extension CardViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height = CGFloat(0)
        
        switch indexPath.row {
        case 0:
            height = kCardTableViewCellHeight
        case 1:
            height = tableView.frame.size.height - kCardTableViewCellHeight
        default:
            height = UITableViewAutomaticDimension
        }
        
        return height
    }
}
