//
//  FirstViewController.swift
//  #IAmRemarkable (tabbed)
//
//  Created by Elizabeth Hensley on 2/16/19.
//  Copyright © 2019 PearlHacks. All rights reserved.
//

import UIKit
import SQLite

class FirstViewController: UIViewController, UITextViewDelegate {

    var database: Connection!

    let entries = Table("entries")
    let entryNumber = Expression<Int64>("entryNumber")
    let submission = Expression<String>("submission")
    let date = Expression<String>("date")
    
    @IBOutlet weak var entryText: UITextView!
    @IBOutlet weak var submitBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // (Using SQLite framework via https://github.com/stephencelis/SQLite.swift)
        do {
            // Create file & store locally
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDirectory.appendingPathComponent("entries").appendingPathExtension("sqlite3")
            let database = try Connection(fileUrl.path)
            self.database = database
        } catch {
            print(error)
        }
        
        // Create table
        do {
            try database.run(entries.create { i in
            i.column(entryNumber, primaryKey: true)
            i.column(submission)
            i.column(date)
        })
        } catch {
            print(error)
        }
        
        // Placeholder text for textbox
        entryText.text = "#IAmRemarkable because ..."
        entryText.textColor = UIColor.lightGray
        entryText.font = UIFont(name: "verdana", size: 13.0)
        entryText.returnKeyType = .done
        entryText.delegate = self
    }
    

    // Create table to store submissions in database
    /*func createTable() {
        let createTable = self.entries.create { (table) in
            table.column(self.entryNumber, primaryKey: true)
            table.column(self.submission)
            table.column(self.date)
        }
        
        do {
            try self.database.run(createTable)
        } catch {
            print(error)
        }
    }*/
    
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
    
    // When button is pressed, the current date and entry are submitted to the database
    @IBAction func ifPressed(_ sender: Any) {
        let currentDate = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let formattedDate = formatter.string(from: currentDate)
        var userEntry = entryText.text!
        if ((userEntry != "") && (userEntry != "#IAmRemarkable because...")) {
            let insertSubmission = entries.insert(submission <- userEntry, date <- formattedDate)
            do {
                try database.run(insertSubmission)
                print("INSERTED SUBMISSION")
            } catch {
                print(error)
            }
        }
    }

    
}

