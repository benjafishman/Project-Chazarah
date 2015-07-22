//
//  Book.swift
//  Project Chazarah
//
//  Created by Ben Fishman on 7/20/15.
//  Copyright (c) 2015 Ben Fishman. All rights reserved.
//

import Foundation
import CoreData

class Book: NSManagedObject {

    @NSManaged var title: String
    @NSManaged var startDate: NSDate
    @NSManaged var numPages: NSNumber
    @NSManaged var author: String
    @NSManaged var category: String
    @NSManaged var logs: NSSet
    
    class func createInManagedObjectContext(moc: NSManagedObjectContext, title: String, author: String, numPages: String) -> Book {
        
        let newBook = NSEntityDescription.insertNewObjectForEntityForName("Book", inManagedObjectContext: moc) as Book
        
        newBook.title = title
        
        newBook.author = author
        
        newBook.numPages = NSNumber(integer: numPages.toInt()!)
        
        // Current date
        
        let date = NSDate()
        
        newBook.startDate = date
        
        //let formatterDate = NSDateFormatter()
        
        //formatterDate.dateStyle = .ShortStyle //Set style of date
    
        return newBook
    }
    
    
    func getTitle() -> String {
        return title
    }
    
    func addLog(item:Log) {
        
        self.mutableSetValueForKey("logs").addObject(item)
    }

}
