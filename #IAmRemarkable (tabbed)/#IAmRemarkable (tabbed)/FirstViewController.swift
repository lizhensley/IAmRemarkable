//
//  FirstViewController.swift
//  #IAmRemarkable (tabbed)
//
//  Created by Elizabeth Hensley on 2/16/19.
//  Copyright © 2019 PearlHacks. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var entryText: UITextView!
    @IBOutlet weak var submitBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        entryText.text = "#IAmRemarkable because ..."
        entryText.textColor = UIColor.lightGray
        entryText.font = UIFont(name: "verdana", size: 13.0)
        
        entryText.delegate = self
    }

    @IBAction func ifPressed(_ sender: Any) {
        
    }
    
    // Placeholder text
    func textViewDidBeginEditing(_ textView: UITextView) {
        if (textView.text == "#IAmRemarkable because ...") {
            textView.text = ""
            textView.textColor = UIColor.black
        }
        textView.becomeFirstResponder()
    }
    
    // Keyboard focus
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if (textView.text == "") {
            textView.text = "#IAmRemarkable because ..."
        }
        textView.resignFirstResponder()
    }

    
}

