//
//  MVDPostTableViewController.swift
//  RedditStarteriOS29
//
//  Created by Michael Di Cesare on 10/9/19.
//  Copyright © 2019 Darin Armstrong. All rights reserved.
//

import UIKit

class MVDPostTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        MVDPostController.shared().fetchPosts { (success) in
            if success {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else {
                print("Post source of truth empty")
            }
        }
    }

    // MARK: - Table view data source

   

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return MVDPostController.shared().post.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as? MVDPostTableViewCell else {return UITableViewCell()}
        
        let post = MVDPostController.shared().post[indexPath.row]
        
        cell.titleLabel.text = post.title
        cell.thumbnailImageView.image = nil
        
        MVDPostController.shared().fetchImage(forPose: post) { (image) in
            if let image = image {
                DispatchQueue.main.async {
                    cell.thumbnailImageView.image = image
                }
            }
        }
        return cell
    }
}
