//
//  Movie.swift
//  MovieBrowser-Demo
//
//  Created by pushpsen airekar on 31/03/19.
//  Copyright © 2019 pushpsen airekar. All rights reserved.
//

import Foundation

struct Movie{
    var movieID: Int
    var movieName: String
    var movieThumbnail: String
    var movieOverview: String
    var movieReleaseDate: String
    var movieTime: Float
    var movieRating: Float
    var moviePoplularity:Float
    
    init(movieID:Int, movieName:String,movieThumbnail:String,movieOverview:String,movieReleaseDate:String,movieTime:Float,movieRating:Float, moviePoplularity: Float) {
        
        self.movieID = movieID
        self.movieName = movieName
        self.movieThumbnail = Constants.imageURL + movieThumbnail
        self.movieOverview = movieOverview
        self.movieReleaseDate = movieReleaseDate
        self.movieTime = movieTime
        self.movieRating = movieRating
        self.moviePoplularity = moviePoplularity
    }
}
