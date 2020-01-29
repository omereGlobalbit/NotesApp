//
//  Constants.swift
//  NotesApp
//
//  Created by Omer Elimelech on 29/01/2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import Foundation


struct Constants{
    
    // MARK: Model strings
    static let note = "Note"
    static let title = "title"
    static let body = "body"
    static let isRecycled = "isRecycled"
    
    
    // MARK: Cell Data
    static let cellReuseId = "cell"
    
    //MARK: General
    static let storyboardId = "Main"
    
    
    // MARK: Folders
    static let notes = "Notes"
    static let folders = "Folders"
    static let archives = "Archives"
    
    
    //MARK: Notes
    static let notesId = "NotesViewController"
    static let archive = "Archive"
    static let edit = "Edit"
    static let delete = "Delete"
    static let restore = "Restore"
    
    
    //MARK: Note
    static let noteId = "NoteViewController"
    static let bodyPlaceHolder = "Write down everything importent......"
    static let untitledNote = "Untitled Note"
    
    
    
    //MARK: System image names
    static let docTextFill = "doc.text.fill"
    static let archiveBox = "archivebox"
    static let pencil = "pencil"
    static let trash = "trash"
    static let restoreArrow = "arrowshape.turn.up.left.fill"
}
