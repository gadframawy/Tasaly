//
//  ViewController.swift
//  Tasaly
//
//  Created by Envy on 5/8/20.
//  Copyright © 2020 framawy. All rights reserved.
//

import UIKit
import Kingfisher

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {
  //object
    var watch = [Result]()
    var selectedIndex = 0
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
//        super.viewDidLoad()
//        func getMovieInPop() {
//            getMoviePop(){ (movie, error) in
//                    self.watch = movie
//                    DispatchQueue.main.async{
//                    self.tableView.reloadData()
//                }
//            }
//        }
        searchBar.delegate = self
    }
    
    // for popularity movies
//    func getMoviePop( completion: @escaping ([Result], Error?) -> Void) {
//
//        let url = URL(string:"http://api.themoviedb.org/3/discover/movie?api_key=fea0b8404179331c4a0a337c42ec4ae2&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&primary_release_year=2020")
//        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
//            guard let data = data else {
//                completion([], error)
//                return
//            }
//            let decoder = JSONDecoder()
//            do {
//                let responseObject = try decoder.decode(MovieResults.self, from: data)
//                completion(responseObject.results, nil)
//             //   print("howa daaaaaaaaaaaaaaaaaa\(responseObject)")
//
//            } catch {
//                completion([], error)
//            }
//        }
//        task.resume()
//    }
    
    // TO SEARCH FOR MOVIES
       func getMovies(){
            getMovieList(query: searchBar.text!) { (movie, error) in
            self.watch = movie
            DispatchQueue.main.async{
            self.tableView.reloadData()
        }
    }
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
//    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
//        searchBar.showsCancelButton = false
//    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        getMovies()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    func getMovieList( query: String , completion: @escaping ([Result], Error?) -> Void) {
        
        let url = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=fea0b8404179331c4a0a337c42ec4ae2" + "&query=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")")
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            guard let data = data else {
                completion([], error)
                return
            }
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(MovieResults.self, from: data)
                completion(responseObject.results, nil)
             //   print("howa daaaaaaaaaaaaaaaaaa\(responseObject)")
                
            } catch {
                completion([], error)
            }
        }
        task.resume()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return watch.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:MyCell=tableView.dequeueReusableCell(withIdentifier: "cell") as! MyCell
        let movie = watch[indexPath.row]
        cell.movieName?.text = movie.title
        cell.movieDes.text = movie.overview
        if let posterPath = movie.posterPath{
            let url = URL(string: "https://image.tmdb.org/t/p/w500/" + posterPath)
            if let url = url{
                cell.movieImage.kf.indicatorType = .activity
                cell.movieImage.kf.setImage(with: url)
            }
        }
        
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetails" {
            let detailsVC = segue.destination as! DetailsViewController
            detailsVC.movie = watch[selectedIndex]
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         selectedIndex = indexPath.row
         performSegue(withIdentifier: "ShowDetails", sender: nil)
         tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}

