//
//  DetailViewController.swift
//  Flix
//
//  Created by Langtian Qin on 2/11/18.
//  Copyright © 2018 Langtian Qin. All rights reserved.
//

import UIKit

enum MK{
    static let title="title"
    static let date="release_date"
    static let overview="overview"
    static let bg="backdrop_path"
    static let ss="poster_path"
}
class DetailViewController: UIViewController {

    @IBOutlet weak var DescLb: UILabel!
    @IBOutlet weak var DateLb: UILabel!
    @IBOutlet weak var TitleLb: UILabel!
    @IBOutlet weak var SsImageView: UIImageView!
    @IBOutlet weak var BgImageView: UIImageView!
    
    var movie:[String:Any]?
    override func viewDidLoad() {
        super.viewDidLoad()

        if let movie=movie{
            TitleLb.text=movie[MK.title]as?String
            DateLb.text=movie[MK.date]as?String
            DescLb.text=movie[MK.overview]as?String
            let BgPath=movie[MK.bg]as!String
            let SsPath=movie[MK.ss]as!String
            let basePath="https://image.tmdb.org/t/p/w500"
            
            let BgURL=URL(string:basePath+BgPath)!
            BgImageView.af_setImage(withURL: BgURL)
            let SsURL=URL(string:basePath+SsPath)!
            SsImageView.af_setImage(withURL: SsURL)
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
