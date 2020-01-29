//
//  NotesNavigation.swift
//  NotesApp
//
//  Created by Omer Elimelech on 29/01/2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import Foundation

enum NoteState{
    case main
    case recycleBin
}
enum NotesNavigation: Navigation {
    case notesPage(state: NoteState)
    case notePage(note: Note?)
    
}

