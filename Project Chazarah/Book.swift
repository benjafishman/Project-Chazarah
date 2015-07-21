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
    
    
    func getTitle() -> String {
        return title
    }

}
