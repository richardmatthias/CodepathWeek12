//
//  NowPlayingViewController.swift
//  Flix
//
//  Created by Langtian Qin on 2/6/18.
//  Copyright © 2018 Langtian Qin. All rights reserved.
//

import UIKit
import AlamofireImage

class NowPlayingViewController: UIViewController,UITableViewDataSource {
    
    var movies:[Movie]=[]
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=FlixTable.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath)as!MovieCell
        cell.movie=movies[indexPath.row]
        return cell
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell=sender as!MovieCell
        let indexPath=FlixTable.indexPath(for: cell)
        let movie=movies[(indexPath?.row)!]
        let desti=segue.destination as!DetailViewController
        desti.movie=movie
    }
    @IBOutlet weak var LoadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var FlixTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //LoadingIndicator.layer.zPosition=500
        //FlixTable.layer.zPosition=1
        //self.LoadingIndicator.startAnimating()
        let refreshControl=UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        FlixTable.insertSubview(refreshControl, at: 0)
        FlixTable.dataSource=self

        MovieApiManager().nowPlayingMovies { (movies: [Movie]?, error: Error?) in
            if let movies = movies {
                self.movies = movies
                self.FlixTable.reloadData()
            }
        }
        FlixTable.rowHeight=200
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @objc func refreshControlAction(_ refreshControl: UIRefreshControl) {
        //LoadingIndicator.stopAnimating()
        MovieApiManager().nowPlayingMovies { (movies: [Movie]?, error: Error?) in
            if let movies = movies {
                self.movies = movies
                self.FlixTable.reloadData()
            }
        }
        self.LoadingIndicator.stopAnimating()
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
