//
//  ChatViewController.swift
//  ParseChat
//
//  Created by Timothy Mak on 2/23/17.
//  Copyright © 2017 Timothy Mak. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var messages: [PFObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableViewAutomaticDimension
        
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ChatViewController.getMessages), userInfo: nil, repeats: true)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getMessages() {
        let query = PFQuery(className: "Message")
        query.includeKey("username")
        query.order(byDescending: "createdAt")
        query.findObjectsInBackground {
            (objects: [PFObject]?, error: Error?) -> Void in
            if error == nil {
                print("Successfully retrieved \(objects!.count) messages.")
                
                if let objects = objects {
                    self.messages = objects
                    self.tableView.reloadData()
                }
            }
            else {
                print("Error fetching messages")
            }
        }
    }
    
    @IBAction func sendMessage(_ sender: Any) {
        let message = PFObject(className: "Message")
        message["text"] = messageTextField.text
        message["username"] = PFUser.current()?.username
        message.saveInBackground { (success: Bool, error: Error?) in
            if(success) {
            }
            else {
            }
        }
        self.messageTextField.text = ""
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell") as! MessageCell
        let message = self.messages[indexPath.row]

        if(message["username"] != nil) {
            cell.nameLabel.text = message["username"] as? String
        }
        else {
            cell.nameLabel.isHidden = true
        }
        
        cell.messageLabel.text = message["text"] as? String
        return cell
        
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
