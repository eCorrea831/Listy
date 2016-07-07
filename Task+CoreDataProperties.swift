//
//  Task+CoreDataProperties.swift
//  Listy
//
//  Created by Erica Correa on 6/2/16.
//  Copyright © 2016 Turn to Tech. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Task {

    @NSManaged var text: String?
    @NSManaged var priority: NSNumber?
    @NSManaged var completed: NSNumber?

}
