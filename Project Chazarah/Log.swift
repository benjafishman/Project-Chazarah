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

}
