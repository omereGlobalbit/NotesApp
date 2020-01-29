//
//  NotesPresenter.swift
//  NotesApp
//
//  Created by Omer Elimelech on 29/01/2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import Foundation
import SwipeCellKit
import CoreData
class NotesPresenter: BasePresenter {
    
    var delegate: NotesDelegate?
    
    init(withDelegate delegate: NotesDelegate){
        self.delegate = delegate
    }

    func handleNotesResult<T: NSManagedObject>(result: fetchResult<T>){
        switch result {
            case .success(let notes):
                if let notes = notes as? [Note]{
                    self.delegate?.notesPresenter(self, didFetchNotes: notes)
                }else{
                    self.delegate?.notesPresenter(self, didFailToFetchNotesWithError: error.myerror)
                }
            case .failure(let error):
                self.delegate?.notesPresenter(self, didFailToFetchNotesWithError: error)
        }
    }
    
    func selectNote(note: Note, at indexPath: IndexPath){
        self.delegate?.notesPresenter(self, didSelectNote: note, at: indexPath)
    }
    
}



