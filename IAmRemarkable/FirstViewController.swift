//
//  FirstViewController.swift
//  #IAmRemarkable (tabbed)
//
//  Created by Elizabeth Hensley on 2/16/19.
//  Copyright © 2019 PearlHacks. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class FirstViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var entryText: UITextView!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var newBkgd: UIImageView!
    @IBOutlet weak var complimentLbl: UILabel!
    

    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        // Placeholder text for textbox
        entryText.text = "#IAmRemarkable because ..."
        entryText.textColor = UIColor.lightGray
        entryText.font = UIFont(name: "verdana", size: 13.0)
        entryText.returnKeyType = .done
        entryText.delegate = self
    }
    
    // Click on textbox
    func textViewDidBeginEditing(_ textView: UITextView) {
        if (textView.text == "#IAmRemarkable because ...") {
            textView.text = ""
            textView.textColor = UIColor.black
            textView.font = UIFont(name: "verdana", size: 15.0)
        }
        textView.becomeFirstResponder()
    }
    
    // Keyboard focus
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
        }
        return true
    }
    
    // End textbox
    func textViewDidEndEditing(_ textView: UITextView) {
        if (textView.text == "") {
            textView.text = "#IAmRemarkable because ..."
            textView.textColor = UIColor.lightGray
            textView.font = UIFont(name: "verdana", size: 13.0)
        }
        textView.resignFirstResponder()
    }
    
    // When button is pressed, the current date/time and entry are logged to the database
    @IBAction func ifPressed(_ sender: Any) {
        // Get current date & time
        let currentDate = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm dd.MM.yyyy"
        let formattedDate = formatter.string(from: currentDate)
        
        // Log to database
        let userEntry = entryText.text!
        let key = ref.child("entries").childByAutoId().key
        let entry = ["entry": userEntry,
                     "date": formattedDate]
        let entryUpdates = ["/entries/ \(String(describing: key))": entry]
        ref.updateChildValues(entryUpdates)
        
        entryText.text = ""
        
        // youAreRemarkable()
    }
    
    // Compliment function
    /*func youAreRemarkable() {
        let complimentArr: [String] = ["You are Amazing!","You are Remarkable!","Keep it up!","You go girl!"]
        let i = Int.random(in: 0 ..< 4)
        complimentLbl.text = complimentArr[i]
        print(complimentArr[i])
        complimentLbl.textColor = UIColor.white
        complimentLbl.font = UIFont(name: "signpainter", size: 30.0)
        newBkgd.isHidden = false
        complimentLbl.isHidden = false
    }*/
    
}

// Working on fade in and fade out functions for the Compliment function
/*
extension UIView {
    func fadeIn(_ duration: TimeInterval = 1.0, delay: TimeInterval = 0.0, completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = 1.0
        }, completion: completion)  }
    
    func fadeOut(_ duration: TimeInterval = 1.0, delay: TimeInterval = 0.0, completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = 0.0
        }, completion: completion)
    }
}*/

