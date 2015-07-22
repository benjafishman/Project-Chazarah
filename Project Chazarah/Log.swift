//
//  Log.swift
//  Project Chazarah
//
//  Created by Ben Fishman on 7/20/15.
//  Copyright (c) 2015 Ben Fishman. All rights reserved.
//

import Foundation
import CoreData

class Log: NSManagedObject {

    @NSManaged var current_page: NSNumber
    @NSManaged var date: NSDate
    @NSManaged var note: String
    @NSManaged var book: Project_Chazarah.Book
    
    class func createInManagedObjectContext(moc: NSManagedObjectContext, note: String, book: Book) -> Log {
        
        let newLog = NSEntityDescription.insertNewObjectForEntityForName("Log", inManagedObjectContext: moc) as Log
        
        newLog.note = note
        
        newLog.current_page = 0
        
        newLog.book = book
        
        // Current date
        
        let date = NSDate()
        
        newLog.date = date
        
        //let formatterDate = NSDateFormatter()
        
        //formatterDate.dateStyle = .ShortStyle //Set style of date
        
        return newLog
    }
    
    func getNote() -> String {
        return note
    }

}
