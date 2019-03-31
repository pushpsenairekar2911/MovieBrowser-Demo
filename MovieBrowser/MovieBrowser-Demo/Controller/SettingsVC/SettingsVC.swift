//
//  SettingsVC.swift
//  MovieBrowser-Demo
//
//  Created by pushpsen airekar on 28/03/19.
//  Copyright © 2019 pushpsen airekar. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController ,UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{

    //Outlets Declarations
    @IBOutlet weak var settingsCollectionView: UICollectionView!
    
    
    //Variable Declarations
    var SettingsItems:[Int]!
    var cellsAcross: CGFloat!
    fileprivate let collectionCellID = "collectionView"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SettingsItems = []
        
        //Register Cell
        let collectionViewNib = UINib.init(nibName: "CollectionViewCell", bundle: nil)
        self.settingsCollectionView.register(collectionViewNib, forCellWithReuseIdentifier: collectionCellID)
        
        //Assigning Delegates
        settingsCollectionView.delegate = self
        settingsCollectionView.dataSource = self
        
         //Function Calling
         handleSettingsVCAppearance()
        self.handleSettingsItems()
    }


    func handleSettingsVCAppearance(){
        
         cellsAcross = 2
         // Navigation bar
        navigationItem.title = "Settings"
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        }
    }
    
    func handleSettingsItems()
    {
        SettingsItems.append(CollectionViewCell.VIEW_PROFILE_CELL)
        SettingsItems.append(CollectionViewCell.PURCHASE_CELL)
        SettingsItems.append(CollectionViewCell.NOTIFICATION_CELL)
        SettingsItems.append(CollectionViewCell.CHAT_SETTINGS_CELL)
        SettingsItems.append(CollectionViewCell.HELP_CELL)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return SettingsItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch SettingsItems[indexPath.row]
        {
        case CollectionViewCell.VIEW_PROFILE_CELL:
           self.viewProfile()
        case CollectionViewCell.PURCHASE_CELL:
            DispatchQueue.main.async{
                self.view.makeToast("This Feature has not been added yet.")
            }
            
        case CollectionViewCell.NOTIFICATION_CELL:
            DispatchQueue.main.async{
                self.view.makeToast("This Feature has not been added yet.")
            }
        case CollectionViewCell.CHAT_SETTINGS_CELL:
            DispatchQueue.main.async{
                self.view.makeToast("This Feature has not been added yet.")
            }
        case CollectionViewCell.HELP_CELL:
            DispatchQueue.main.async{
                self.view.makeToast("This Feature has not been added yet.")
            }
        default: break
            
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var widthRemainingForCellContent = collectionView.bounds.width
        if let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout {
            let borderSize: CGFloat = flowLayout.sectionInset.left + flowLayout.sectionInset.right
            widthRemainingForCellContent -= borderSize + ((cellsAcross - 1) * flowLayout.minimumInteritemSpacing)
        }
        let cellWidth = widthRemainingForCellContent / cellsAcross
        return CGSize(width: cellWidth, height: cellWidth + 50)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var collectionViewCell = CollectionViewCell()
        print("added collectionViewCell")
        
        collectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCellID, for: indexPath) as! CollectionViewCell
        
        switch SettingsItems[indexPath.row]
        {
        case CollectionViewCell.VIEW_PROFILE_CELL:
           collectionViewCell.movieName.text = "View Profile"
            collectionViewCell.movieThumbnail.image = #imageLiteral(resourceName: "profile")
            
        case CollectionViewCell.PURCHASE_CELL:
         
            collectionViewCell.movieName.text = "Purchases"
             collectionViewCell.movieThumbnail.image = #imageLiteral(resourceName: "purchase")
            
        case CollectionViewCell.NOTIFICATION_CELL:
            
            collectionViewCell.movieName.text = "Notification Settings"
             collectionViewCell.movieThumbnail.image = #imageLiteral(resourceName: "notification")
            
        case CollectionViewCell.CHAT_SETTINGS_CELL:
            
            collectionViewCell.movieName.text = "Chat Settings"
            collectionViewCell.movieThumbnail.image = #imageLiteral(resourceName: "chat")
          
        case CollectionViewCell.HELP_CELL:
            
            collectionViewCell.movieName.text = "Help"
             collectionViewCell.movieThumbnail.image = #imageLiteral(resourceName: "help")
            
        default: break
           
        }
        
        return collectionViewCell
    }
    
    func viewProfile(){
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let movieDetailVC = storyboard.instantiateViewController(withIdentifier: "movieDetailsVC") as! MovieDetailsVC
        movieDetailVC.hidesBottomBarWhenPushed = true
        movieDetailVC.isViewProfile = true
        navigationController?.pushViewController(movieDetailVC, animated: true)
        
    }
    
}

