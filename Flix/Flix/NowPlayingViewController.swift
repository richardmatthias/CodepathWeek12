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
    
    var movies:[[String:Any]]=[]
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=FlixTable.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath)as!MovieCell
        let movie=movies[indexPath.row]
        let title=movie["title"]as!String
        let overview=movie["overview"]as!String
        cell.TitleLabel.text=title
        cell.OverviewLabel.text=overview;
        let posterPathString=movie["poster_path"]as!String
        let baseURLString="https://image.tmdb.org/t/p/w500"
        let posterURL=URL(string:baseURLString+posterPathString)!
        cell.PhotoView.af_setImage(withURL: posterURL)
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

        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                let movies=dataDictionary["results"]as![[String:Any]]
                self.movies=movies
                // TODO: Get the array of movies
                self.FlixTable.reloadData()
                // TODO: Store the movies in a property to use elsewhere
                // TODO: Reload your table view data
                
            }
        }
        FlixTable.rowHeight=200
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @objc func refreshControlAction(_ refreshControl: UIRefreshControl) {
        //LoadingIndicator.stopAnimating()
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                let movies=dataDictionary["results"]as![[String:Any]]
                self.movies=movies
                self.FlixTable.reloadData()
                
            }
            self.FlixTable.reloadData()
            
            // Tell the refreshControl to stop spinning
            refreshControl.endRefreshing()
        }
        self.LoadingIndicator.stopAnimating()
        task.resume()
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
