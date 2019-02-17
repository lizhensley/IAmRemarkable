//
//  SecondViewController.swift
//  #IAmRemarkable (tabbed)
//
//  Created by Elizabeth Hensley on 2/16/19.
//  Copyright © 2019 PearlHacks. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class SecondViewController: UIViewController, UITabBarControllerDelegate {
    
    
    @IBOutlet weak var switchView: UITabBarItem!
    @IBOutlet weak var scrolly: UIScrollView!
    
    var isLoadingViewController = false
    
    var ref: DatabaseReference!
    var numberOfLabels = 0
    
    var postData = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        isLoadingViewController = true
        viewLoadSetup()
        
    }
    
    
    /*func tabBarController(_ tabBarController: UITabBarController,
                          didSelect viewController: UIViewController) {
        let tabBarIndex = tabBarController.selectedIndex
        if tabBarIndex == 1 {
            
            self.viewDidAppear(true)
            
        }
    }*/
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isLoadingViewController {
            isLoadingViewController = false
        } else {
            viewLoadSetup()
        }
        
    }
    
    func viewLoadSetup() {
        ref = Database.database().reference()
        
        getEntries()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.tabBarController?.delegate = self
    
    }

    func getEntries() {
        ref.child("entries").observeSingleEvent(of: .value, with: {(snap) in
            
            // Retrieve database entries
            if let userDict = snap.value as? [String:AnyObject]{
                for each in userDict as [String: AnyObject] {
                    let autoID = each.0
                    self.ref.child("entries").child(autoID).observe(.value, with: {(Dict) in
                        if let dictionary = Dict.value as? [String:AnyObject]{
                            let submission = dictionary["entry"] as! String
                            let date = dictionary["date"] as! String
                            let position = CGRect(x: 20, y: 50 + CGFloat(150 * self.numberOfLabels), width: 200, height: 100)
                            self.numberOfLabels += 1
                            self.coolLabel(submission, currentDate: date, labelPosition: position)
                            
                        }
                    })
                }
            }
        })
    }
    
    
    // Label creation
    func coolLabel(_ text: String, currentDate: String, labelPosition: CGRect) {
        let newLabel = UILabel(frame: labelPosition)
        newLabel.text = text
        newLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        newLabel.numberOfLines = 0
        newLabel.textColor = UIColor.lightGray
        newLabel.font = UIFont(name: "verdana", size: 13.0)
        newLabel.backgroundColor = UIColor.white
        self.view.addSubview(newLabel)
       
    }


}

