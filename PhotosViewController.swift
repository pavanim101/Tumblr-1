//
//  PhotosViewController.swift
//  Tumblr
//
//  Created by Dominique Adapon on 6/21/17.
//  Copyright © 2017 Dominique Adapon. All rights reserved.
//

import UIKit
import AlamofireImage

class PhotosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var photoTable: UITableView!
    
    var posts: [[String: Any]] = []


    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Implement pull to refresh
        let refreshControl = UIRefreshControl()
        
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: .valueChanged)
        
        photoTable.insertSubview(refreshControl, at: 0)
    
        photoTable.delegate = self
        photoTable.dataSource = self
        
        fetchPosts()
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //Functions for initializing table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("load cell")
        let cell = photoTable.dequeueReusableCell(withIdentifier: "PhotoCell") as! PhotoCell
        let post = posts[indexPath.row]
        
        if let photos = post["photos"] as? [[String: Any]] {
            let photo = photos[0]
            let originalSize = photo["original_size"] as! [String: Any]
            let urlString = originalSize["url"] as! String
            let url = URL(string: urlString)
            
            cell.imageDisplay.af_setImage(withURL: url!)

        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    
    
    //Passes in photo data to detail view
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Initialize destination view controller from segue and cast
        let photoDetailViewController = segue.destination as! PhotoDetailsViewController
        
        //Initialize the selected cell and cast
        let cell = sender as! PhotoCell
        
        //Get the image of the current cell and assign to detail VC property
        photoDetailViewController.image = cell.imageDisplay.image
    }
    
    
    //Pull to refresh
    func refreshControlAction(_ refreshControl: UIRefreshControl){
        fetchPosts()
        
        self.photoTable.reloadData()
            
        refreshControl.endRefreshing()
    }
    
    //Fetches posts - network task
    func fetchPosts() {
        
        let url = URL(string: "https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/posts/photo?api_key=Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV")!
        
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        print(session)
        
        session.configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        print("configuration??")
        
        let task = session.dataTask(with: url) { (data,response, error) in
            if let error = error {
                print (error.localizedDescription)
            } else if let data = data,
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                print(dataDictionary)
                
                let responseDictionary = dataDictionary["response"] as! [String:Any]
                
                self.posts = responseDictionary["posts"] as! [[String: Any]]
                print(self.posts)
                
                self.photoTable.reloadData()
                
            }
        }
        
        task.resume()
    }
    
}
