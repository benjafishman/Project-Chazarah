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
        title = "Learnings!"
        
        var nib = UINib(nibName: "BookTableViewCell", bundle: nil)
        
        tableView.registerNib(nib, forCellReuseIdentifier: "bookCell")
        
        fetchLog()
        
        //println(managedObjectContext)
        
        //let newItem = NSEntityDescription.insertNewObjectForEntityForName("Learning", inManagedObjectContext: self.managedObjectContext!) as Learning
        
        //tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
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
            
            return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        println("CLICKED CELL")
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

