//
//  PhotoDetailsViewController.swift
//  Tumblr
//
//  Created by Pavani Malli on 6/22/17.
//  Copyright © 2017 Dominique Adapon. All rights reserved.
//

import UIKit

class PhotoDetailsViewController: UIViewController {
    
    var image: UIImage!
    
    @IBOutlet weak var tumblrImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tumblrImageView.image = image

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
