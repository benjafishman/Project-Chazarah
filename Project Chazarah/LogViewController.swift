//
//  LogViewController.swift
//  Project Chazarah
//
//  Created by Ben Fishman on 7/21/15.
//  Copyright (c) 2015 Ben Fishman. All rights reserved.
//

import Foundation

import UIKit

import CoreData

class LogViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    
    private var book: Book!
    
    var passedBook : Book?
    
    var logs = [Log]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Logs"
        
        book = passedBook
        
        println("In LogViewController")
        
        println(book?.getTitle())
        
        label.text = book?.getTitle()
        
        // Get all logs associated with passedBook and store them in array
        for object in book.logs.allObjects {
            
            let o = object as Log
            println("\(o.getNote())")
            logs.append(o)
            //i++
        }
    
    
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
