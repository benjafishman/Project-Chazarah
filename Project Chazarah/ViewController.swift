//
//  ViewController.swift
//  Project Chazarah
//
//  Created by Ben Fishman on 7/12/15.
//  Copyright (c) 2015 Ben Fishman. All rights reserved.
//

import UIKit

import CoreData

/**
 * Define the custom table view cell that displays Book entities
 */
class BookTableViewCell : UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    func setTitle(title: String) {
        titleLabel.text = title
    }
    
    func setAuthor(name: String) {
        authorLabel.text = name
    }
    
    
}

class ViewController: UIViewController {
    
    let managedObjectContext =
    (UIApplication.sharedApplication().delegate
        as AppDelegate).managedObjectContext
    
    var books = [Book]()
    
    private var passedBook : Book?
    

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        title = "ספרים"
        
        var nib = UINib(nibName: "BookTableViewCell", bundle: nil)
        
        tableView.registerNib(nib, forCellReuseIdentifier: "bookCell")
        
        fetchLog()
    
    }
    
    func fetchLog() {
        let fetchRequest = NSFetchRequest(entityName: "Book")
        
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let fetchResults = managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as? [Book] {
            books = fetchResults
        }
    }
    
    @IBAction func addButtonPressed(sender: AnyObject) {
        
        println("add button pressed")
        var alertController = UIAlertController(title: "Enter Book Info",
            message: "Enter Text",
            preferredStyle: .Alert)
        
        var titleTextField: UITextField?
        alertController.addTextFieldWithConfigurationHandler {
            (titleField) -> Void in
            titleTextField = titleField
            titleField.placeholder = "Title"
        }
        
        var authorTextField: UITextField?
        alertController.addTextFieldWithConfigurationHandler {
            (authorField) -> Void in
            authorTextField = authorField
            authorField.placeholder = "Author"
        }
        
        var numberOfPagesTextField: UITextField?
        alertController.addTextFieldWithConfigurationHandler {
            (numberField) -> Void in
            numberOfPagesTextField = numberField
            numberField.placeholder = "Number of pages"
        }
        
        
        alertController.addAction(UIAlertAction(title: "Ok",
            style: .Default,
            handler: { (action) -> Void in
                if let titleField = titleTextField  {
                    if let authorField = authorTextField {
                        if let numberField = numberOfPagesTextField {
                            self.saveNewItem(titleField.text, author: authorField.text, number: numberField.text)
                    }
                    
                }
                }}))
        
        self.presentViewController(alertController,
            animated: true,
            completion: nil)
    }
    
    func saveNewItem(title : String, author: String, number: String) {
        println("\(title)")
        
        //Create new Book with user data
        var newBook = Book.createInManagedObjectContext(self.managedObjectContext!, title: title, author: author, numPages: number)
        
        /*
        * Doin some fake jazz to preload logItem2, i.e. not production worthy code
        */
        for var i = 0; i < 3; i++
        {
            println("here \(i)")
            var newNote = title + " :log-\(i)"
            
            var newLog = Log.createInManagedObjectContext(self.managedObjectContext!, note: newNote, book: newBook)
            
            newBook.addLog(newLog)
            
            //newLogItem2.logitem = newLogItem
        }
        
        // Update the array containing the table view row data
        self.fetchLog()
        
        // Animate in the new row
        // Use Swift's find() function to figure out the index of the newLogItem
        // after it's been added and sorted in our logItems array
        if let newItemIndex = find(books, newBook) {
            // Create an NSIndexPath from the newItemIndex
            let newBookIndexPath = NSIndexPath(forRow: newItemIndex, inSection: 0)
            // Animate in the insertion of this row
            tableView.insertRowsAtIndexPaths([ newBookIndexPath ], withRowAnimation: .Automatic)
            save()
        }
    }
    
    func save() {
        var error : NSError?
        if(managedObjectContext!.save(&error) ) {
            println(error?.localizedDescription)
        }
    }

    
    // MARK: UITableViewDataSource
    func tableView(tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
            return books.count
    }
    
    func tableView(tableView: UITableView,
        cellForRowAtIndexPath
        indexPath: NSIndexPath) -> UITableViewCell {
            
            var cell:BookTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("bookCell") as BookTableViewCell
            
            let book = books[indexPath.row]
            
            cell.setTitle(book.title)
            cell.setAuthor(book.author)
            
            return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        println("CLICKED CELL")
        
        let book = books[indexPath.row]
                
        passedBook = book
        
        self.performSegueWithIdentifier("passBookSegue", sender: self)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        
        if(segue.identifier == "passBookSegue") {
            
            let navVC = segue.destinationViewController as UINavigationController
            
            if let vc = navVC.topViewController as? LogViewController {
                vc.passedBook = passedBook!
            }
        }
        
        
    }

}

