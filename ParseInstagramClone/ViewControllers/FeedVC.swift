//
//  FeedVC.swift
//  ParseInstagramClone
//
//  Created by Ceren Çapar on 3.11.2021.
//

import UIKit
import Parse

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource{
    @IBOutlet weak var tableView: UITableView!
    
    var postOwnerArray = [String]()
    var uuidArray = [String]()
    var commentArray = [String]()
    var postImageArray = [PFFileObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        getData()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(getData), name: NSNotification.Name(rawValue: "newPost"), object: nil)
    }
    
   @objc func getData() {
        let query = PFQuery(className: "Posts")
       
       query.addDescendingOrder("createdAt")
        
        query.findObjectsInBackground { objects, error in
            if error != nil {
                let alert = UIAlertController(title: "ERROR", message: error?.localizedDescription ?? "Error", preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            } else {
                self.postOwnerArray.removeAll(keepingCapacity: false)
                self.commentArray.removeAll(keepingCapacity: false)
                self.uuidArray.removeAll(keepingCapacity: false)
                self.postImageArray.removeAll(keepingCapacity: false)
                
                if objects != nil {
                    for object in objects! {
                        
                        if let postOwner = object.object(forKey: "postOwner") as? String{
                            self.postOwnerArray.append(postOwner)
                            self.commentArray.append(object.object(forKey: "comments") as! String)
                            self.uuidArray.append(object.object(forKey: "postid") as! String)
                            self.postImageArray.append(object.object(forKey: "postImage") as! PFFileObject)
                        }
                        
                        
                    }
                }
                self.tableView.reloadData()
            }
        }
    }
    
    
    
    
    @IBAction func logOutButtonClicked(_ sender: Any) {
        PFUser.logOutInBackground { error in
            if error != nil {
                let alert = UIAlertController(title: "ERROR", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            }else {
                self.performSegue(withIdentifier: "toSignInVC", sender: nil)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postOwnerArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
        
        cell.postOwnerLabel.text = self.postOwnerArray[indexPath.row].uppercased()
        cell.uuidLabel.text = self.uuidArray[indexPath.row]
        cell.commentLabel.text = self.commentArray[indexPath.row]
        
        postImageArray[indexPath.row].getDataInBackground { data, error in
            if error != nil {
                
            }else {
                cell.postImageView.image = UIImage(data: data!)
            }
        }
         return cell
    }
    


}
