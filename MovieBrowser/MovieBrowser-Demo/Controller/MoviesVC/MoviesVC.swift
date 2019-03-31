//
//  MoviesVC.swift
//  MovieBrowser-Demo
//
//  Created by pushpsen airekar on 28/03/19.
//  Copyright © 2019 pushpsen airekar. All rights reserved.
//

import UIKit


class MoviesVC: UIViewController, UISearchBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout, UISearchResultsUpdating{
    
    

    //Outlets Declarations
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    
    
    //Variable Declarations
    var movies = [Movie]()
    var cellsAcross: CGFloat!

    var search = "Avengers"
    var searchController:UISearchController!
    fileprivate let collectionCellID = "collectionView"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        let editedSearch = search.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let url = Constants.url + Constants.apiKey + "&query=" + editedSearch!
        print("url is: \(url)")
        fetchMovieInformation(url: url)
        
        //Register Cell
        let collectionViewNib = UINib.init(nibName: "CollectionViewCell", bundle: nil)
        self.moviesCollectionView.register(collectionViewNib, forCellWithReuseIdentifier: collectionCellID)
        
        //Assigning Delegates
        moviesCollectionView.delegate = self
        moviesCollectionView.dataSource = self
        
        
         //Function Calling
        handleMoviesVCAppearance()
    }
    
    func handleMoviesVCAppearance(){
        
        cellsAcross = 2
        
        //Searchbar
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        
        // Navigation bar
        navigationItem.title = "Movies"
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationItem.searchController = searchController
        }
   
    }
    
     func fetchMovieInformation(url: String) {
        let movieInfo = getJSON(path: url)
        for result in movieInfo["results"].arrayValue {
            
            let name = result["original_title"].stringValue
            let thumbnail = result["poster_path"].stringValue
            let runTime = result["runtime"].floatValue
            let releaseDate = result["release_date"].stringValue
            let overview = result["overview"].stringValue
            let rating = result["vote_average"].floatValue
            let id = result["id"].intValue
            let popularity = result["popularity"].floatValue
            
            movies.append(Movie(movieID: id, movieName: name, movieThumbnail: thumbnail, movieOverview: overview, movieReleaseDate: releaseDate, movieTime: runTime, movieRating: rating, moviePoplularity: popularity))
        }
        print("movies: \(movies)")
        print("movieInfo: \(movieInfo)")
    }
    
    private func getJSON(path: String) -> JSON {
        guard let url = URL(string: path) else { return JSON.null }
        do {
            let data = try Data(contentsOf: url)
            return try JSON(data: data)
        }
        catch {
            return JSON.null
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectedCell:CollectionViewCell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let movieDetailVC = storyboard.instantiateViewController(withIdentifier: "movieDetailsVC") as! MovieDetailsVC
       movieDetailVC.isViewProfile = false
       movieDetailVC.movieInfo = selectedCell.currentMovie
       movieDetailVC.hidesBottomBarWhenPushed = true
       navigationController?.pushViewController(movieDetailVC, animated: true)
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
        
        let movie = movies[indexPath.row]
        
        collectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCellID, for: indexPath) as! CollectionViewCell
        collectionViewCell.currentMovie = movie
        collectionViewCell.movieName.text = movie.movieName
        let url = NSURL(string: movie.movieThumbnail)
        collectionViewCell.movieThumbnail.sd_setImage(with: url as URL?, placeholderImage: #imageLiteral(resourceName: "default-thumbnail"))
        return collectionViewCell
    }
    
    @IBAction func sortItemPressed(_ sender: Any) {
        
        let actionSheetController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let sortByPoplularity: UIAlertAction = UIAlertAction(title: "Sort By Poplularity", style: .default) { action -> Void in
            
            let sortedArray = self.movies.sorted(by: { $0.moviePoplularity > $1.moviePoplularity })
            self.movies = sortedArray
            self.moviesCollectionView.reloadData()
            
        }
        sortByPoplularity.setValue(#imageLiteral(resourceName: "poplularity"), forKey: "image")
        
        let sortByRating: UIAlertAction = UIAlertAction(title: "Sort By Rating", style: .default) { action -> Void in
            
            let sortedArray = self.movies.sorted(by: { $0.movieRating > $1.movieRating })
            self.movies = sortedArray
            self.moviesCollectionView.reloadData()
            
        }
        sortByRating.setValue(#imageLiteral(resourceName: "rating"), forKey: "image")
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            print("Cancel")
        }
        cancelAction.setValue(UIColor.red, forKey: "titleTextColor")
        
        actionSheetController.addAction(sortByPoplularity)
        actionSheetController.addAction(sortByRating)
        actionSheetController.addAction(cancelAction)
        present(actionSheetController, animated: true, completion: nil)
        
    }
    @IBAction func orderByPressed(_ sender: Any) {
        
        let actionSheetController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let singleView: UIAlertAction = UIAlertAction(title: "Single View", style: .default) { action -> Void in
            self.cellsAcross = 1
            self.moviesCollectionView.reloadData()
        }
        singleView.setValue(#imageLiteral(resourceName: "normal"), forKey: "image")
        
        let splitView: UIAlertAction = UIAlertAction(title: "Split View", style: .default) { action -> Void in
            
            self.cellsAcross = 2
            self.moviesCollectionView.reloadData()
            
        }
        splitView.setValue(#imageLiteral(resourceName: "split"), forKey: "image")
        
        let compactView: UIAlertAction = UIAlertAction(title: "Compact View", style: .default) { action -> Void in
            
            self.cellsAcross = 3
            self.moviesCollectionView.reloadData()
            
        }
        compactView.setValue(#imageLiteral(resourceName: "compact"), forKey: "image")
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            print("Cancel")
        }
        cancelAction.setValue(UIColor.red, forKey: "titleTextColor")
        
        actionSheetController.addAction(singleView)
        actionSheetController.addAction(splitView)
        actionSheetController.addAction(compactView)
        actionSheetController.addAction(cancelAction)
        present(actionSheetController, animated: true, completion: nil)
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
        if searchBar.text == "" || searchBar.text == nil {
            
            
        }else{
        let editedSearch = searchController.searchBar.text?.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let url = Constants.url + Constants.apiKey + "&query=" + editedSearch!
        print("modified url is: \(url)")
        movies.removeAll()
        fetchMovieInformation(url: url)
        moviesCollectionView.reloadData()
        searchController.isActive = false
        }
    }
    
   
}

