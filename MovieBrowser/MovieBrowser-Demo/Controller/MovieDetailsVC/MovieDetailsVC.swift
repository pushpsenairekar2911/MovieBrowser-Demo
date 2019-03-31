//
//  MovieDetailsVC.swift
//  MovieBrowser-Demo
//
//  Created by pushpsen airekar on 31/03/19.
//  Copyright © 2019 pushpsen airekar. All rights reserved.
//

import UIKit

class MovieDetailsVC: UIViewController {

    //Outlets Declarations
    @IBOutlet weak var moviePosterBackground: UIImageView!
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieRating: UILabel!
    @IBOutlet weak var movieOverview: UILabel!
    @IBOutlet weak var movieReleaseDate: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var logoBackground: UIView!
    
    
    //Vatiable Declarations
    var movieInfo:Movie!
    var isViewProfile:Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Function Calling
        self.handleDetailVCApperance()
    }
    
    func handleDetailVCApperance(){
        //
        if(isViewProfile == false){
            
            movieName.text = movieInfo.movieName
            movieRating.text = "Rating: " + String(movieInfo.movieRating)
            movieReleaseDate.text = "Release Date: " + movieInfo.movieReleaseDate
            movieOverview.text = movieInfo.movieOverview
            let url = NSURL(string: movieInfo.movieThumbnail)
            moviePoster.sd_setImage(with: url as URL?, placeholderImage: #imageLiteral(resourceName: "default-thumbnail"))
            
            //BackgroundViewAppearance
            moviePosterBackground.sd_setImage(with: url as URL?, placeholderImage: #imageLiteral(resourceName: "default-thumbnail"))
            moviePosterBackground.addBlur()
            moviePosterBackground.roundCorners([ .layerMinXMaxYCorner,.layerMaxXMaxYCorner], radius: 25, borderColor: .clear, borderWidth: 0, withBackgroundColor: "FFFFFF")
            moviePosterBackground.clipsToBounds = true
            
            //NavigationBar Appearance
            self.navigationController?.isNavigationBarHidden = true
            
            logoBackground.roundCorners([ .layerMinXMaxYCorner,.layerMaxXMaxYCorner], radius: 25, borderColor: .clear, borderWidth: 0, withBackgroundColor: "FFFFFF")
        }else{
            
            movieName.text = "Pushpsen Airekar"
            movieRating.text = " iOS Developer"
            movieReleaseDate.text = "Birth Date: 29/11/1994"
            movieOverview.text = "Experienced iOS Developer with a demonstrated history of working in the Computer Software industry. Strong engineering professional with a Bachelor of Engineering (B.E.) focused in Computer Engineering from Mumbai University Mumbai."
            moviePoster.image = #imageLiteral(resourceName: "profile-1")
            
            //BackgroundViewAppearance
            moviePosterBackground.image = #imageLiteral(resourceName: "profile-1")
            moviePosterBackground.addBlur()
            moviePosterBackground.roundCorners([ .layerMinXMaxYCorner,.layerMaxXMaxYCorner], radius: 25, borderColor: .clear, borderWidth: 0, withBackgroundColor: "FFFFFF")
            moviePosterBackground.clipsToBounds = true
            
            //NavigationBar Appearance
            self.navigationController?.isNavigationBarHidden = true
            
            logoBackground.roundCorners([ .layerMinXMaxYCorner,.layerMaxXMaxYCorner], radius: 25, borderColor: .clear, borderWidth: 0, withBackgroundColor: "FFFFFF")
        }
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
        self.navigationController?.isNavigationBarHidden = false
        self.hidesBottomBarWhenPushed = false
    }
    
}
