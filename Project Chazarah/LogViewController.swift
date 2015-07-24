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

class LogViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var book: Book!
    
    var passedBook : Book?
    
    var logs = [Log]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Logs"
        
        book = passedBook
        
        println("In LogViewController")
        
        println(book?.getTitle())
        
        // registrer table view
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")

        
        // Get all logs associated with passedBook and store them in array
        for object in book.logs.allObjects {
            
            let o = object as Log
            println("\(o.getNote())")
            logs.append(o)
            //i++
        }
    
    
    
    }
    
    
    
    // MARK: UITableViewDataSource
    func tableView(tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
            return logs.count
    }
    
    func tableView(tableView: UITableView,
        cellForRowAtIndexPath
        indexPath: NSIndexPath) -> UITableViewCell {
            
            
            let cell = tableView.dequeueReusableCellWithIdentifier("Cell")
                as UITableViewCell
            
            cell.textLabel!.text = logs[indexPath.row].getNote()
            
            return cell
    }
    

    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        
        println("CLICKED CELL")
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    
    /**
    Explanation:
    When a user clicks the add button, they need to be presented with the add createLogView and there we must pass the Book object of which they were viewing - in this case we just pass along the book that was passed originally to this view
    */
    
    @IBAction func addLogButtonPressed(sender: AnyObject) {
        
        self.performSegueWithIdentifier("createLogSegue", sender: self)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        
        if(segue.identifier == "createLogSegue") {
            
            if let vc = segue.destinationViewController as? CreateLogViewController {
                vc.passedBook = passedBook!
            }
        }
        
        
    }
    
    
}
