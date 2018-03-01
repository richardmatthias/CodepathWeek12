//
//  SuperheroController.swift
//  Flix
//
//  Created by Langtian Qin on 2/11/18.
//  Copyright © 2018 Langtian Qin. All rights reserved.
//

import UIKit

class SuperheroController: UIViewController,UICollectionViewDataSource {
    
    @IBOutlet weak var CollView: UICollectionView!
    
    var movies:[Movie]=[]
    override func viewDidLoad() {
        super.viewDidLoad()
        CollView.dataSource=self
        fetchMovies()
        self.CollView.reloadData()
        // Do any additional setup after loading the view.
        let layout=CollView.collectionViewLayout as!UICollectionViewFlowLayout
        layout.minimumInteritemSpacing=5
        layout.minimumLineSpacing=layout.minimumInteritemSpacing
        let cellsPerLine:CGFloat=2
        let interitem=layout.minimumInteritemSpacing*(cellsPerLine-1)
        let width=CollView.frame.size.width/cellsPerLine-interitem/cellsPerLine
        layout.itemSize=CGSize(width:width,height:1.5*width)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell=CollView.dequeueReusableCell(withReuseIdentifier: "PosterCell", for: indexPath)as!PosterCell
        let movie=movies[indexPath.row]
        let posterURL=movie.posterUrl
        cell.imageView.af_setImage(withURL: posterURL!)
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell=sender as!PosterCell
        let indexPath=CollView.indexPath(for: cell)
        let movie=movies[(indexPath?.row)!]
        let desti=segue.destination as!DetailViewController
        desti.movie=movie
    }
    
    func fetchMovies(){
        MovieApiManager().popularMovies { (movies: [Movie]?, error: Error?) in
            if let movies = movies {
                self.movies = movies
                self.CollView.reloadData()
            }
        }
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


}
