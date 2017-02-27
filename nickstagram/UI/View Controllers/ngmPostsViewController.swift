//
//  ngmPostsViewController.swift
//  nickstagram
//
//  Created by Nick McDonald on 2/25/17.
//  Copyright © 2017 Nick McDonald. All rights reserved.
//

import UIKit
import SVProgressHUD

class ngmPostsViewController: UIViewController {

    @IBOutlet weak var postsTableView: UITableView!
    fileprivate var posts: [ngmPost]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "nickstagram"
        
        self.postsTableView.delegate = self
        self.postsTableView.dataSource = self
        
        // TableView height.
        self.postsTableView.rowHeight = UITableViewAutomaticDimension
        self.postsTableView.estimatedRowHeight = 435
        
        self.loadPosts()
    }
    
    func loadPosts() {
        ngmPost.getPosts(success: { (posts: [ngmPost]) in
            // Code
            self.posts = posts
            self.postsTableView.reloadData()
        }) { (error: Error?) in
            SVProgressHUD.showError(withStatus: error?.localizedDescription)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ngmPostsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ngmPostTableViewCell = self.postsTableView.dequeueReusableCell(withIdentifier: "postTableViewCell", for: indexPath) as! ngmPostTableViewCell
        
        cell.postData = self.posts![indexPath.section]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerViewHeight: CGFloat = 26
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: headerViewHeight))
        headerView.backgroundColor = UIColor.black.withAlphaComponent(0.25)
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = headerView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        headerView.addSubview(blurEffectView)
        
        let usernameLabel: UILabel = UILabel() //UILabel(frame: CGRect(x: 8, y: 6, width: UIScreen.main.bounds.width - 8, height: 14))
        usernameLabel.text = self.posts![section].postAuthor!.username
        usernameLabel.textColor = UIColor.white
        usernameLabel.font = UIFont(name: "TrebuchetMS", size: 15.0)
        usernameLabel.sizeToFit()
        let usernameFrame: CGRect = CGRect(x: 8, y: 6, width: usernameLabel.frame.size.width, height: 14)
        usernameLabel.frame = usernameFrame
        headerView.addSubview(usernameLabel)
        
        let createdAtLabel: UILabel = UILabel()
        createdAtLabel.text = self.posts![section].formattedCreatedAt
        createdAtLabel.textColor = UIColor.white
        createdAtLabel.font = UIFont(name: "TrebuchetMS", size: 15.0)
        createdAtLabel.sizeToFit()
        let createdAtFrame: CGRect = CGRect(x: (UIScreen.main.bounds.width - 8) - createdAtLabel.frame.size.width, y: 6, width: createdAtLabel.frame.size.width, height: 14)
        createdAtLabel.frame = createdAtFrame
        headerView.addSubview(createdAtLabel)
        
        return headerView
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.posts?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
}
