//
//  NoteWorker.swift
//  NotesApp
//
//  Created by Omer Elimelech on 29/01/2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import Foundation




class NotesWorker {
    
    func archiveNote(note: Note){
        note.setValue(true, forKey: Constants.isRecycled)
        CoreDataManager.shared.saveContext()
    }
    
    func restoreNote(note: Note){
        note.setValue(false, forKey: Constants.isRecycled)
        CoreDataManager.shared.saveContext()
    }
    
    func deleteNote(note: Note?){
        CoreDataManager.shared.delete(object: note)
    }
    
    func createNewNote() -> Note? {
        guard let note = CoreDataManager.shared.getEntity(forType: Note.self, entityName: Constants.note) else {return nil}
        note.setValue(false, forKey: Constants.isRecycled)
        return note
    }
      
      func saveNote(note: Note, title: String, body: String){
          note.setValue(body, forKey: Constants.body)
          note.setValue(title, forKey: Constants.title)
          CoreDataManager.shared.save(entityName: Constants.note, object: note)
    }
      
    func updateNote(note: Note?, withValue value: Any?, forKey key: String){
          note?.setValue(value, forKey: key)
    }
}
