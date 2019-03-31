//
//  CollectionViewCell.swift
//  MovieBrowser-Demo
//
//  Created by pushpsen airekar on 30/03/19.
//  Copyright © 2019 pushpsen airekar. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    //Outlets Declarations
    @IBOutlet weak var movieThumbnail: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    
    //Variable Declarations
    var currentMovie:Movie!
    
    static let VIEW_PROFILE_CELL = 0
    static let PURCHASE_CELL = 1
    static let CHAT_SETTINGS_CELL = 2
    static let NOTIFICATION_CELL = 3
    static let HELP_CELL = 4
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
        //Function Calling
        self.handleCollectionViewCellAppearance()
    }
    
    func handleCollectionViewCellAppearance(){
       
          movieThumbnail.roundCorners([ .layerMaxXMinYCorner,.layerMinXMinYCorner], radius: 10, borderColor: .clear, borderWidth: 0, withBackgroundColor: "FFFFFF")
        
    }

}
