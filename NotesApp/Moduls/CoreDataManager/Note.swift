//
//  Note.swift
//  NotesApp
//
//  Created by Omer Elimelech on 29/01/2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import Foundation
import CoreData


@objc(Note)
class Note: NSManagedObject {

    @NSManaged var title : NSString

}
