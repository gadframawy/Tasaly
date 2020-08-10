//
//  DetailsViewController.swift
//  Tasaly
//
//  Created by Envy on 5/10/20.
//  Copyright © 2020 framawy. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
     var movie : Result!


    @IBOutlet weak var movieDes: UITextView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        movieName.text = movie.title
        movieDes.text = movie.overview
        if let posterPath = movie.posterPath{
                   let url = URL(string: "https://image.tmdb.org/t/p/w500/" + posterPath)
                   if let url = url{
                       movieImage.kf.indicatorType = .activity
                       movieImage.kf.setImage(with: url)
                   }
               }

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func dismissBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}
