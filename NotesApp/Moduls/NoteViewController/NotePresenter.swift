//
//  NotePresenter.swift
//  NotesApp
//
//  Created by Omer Elimelech on 29/01/2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import Foundation



class NotePresenter: BasePresenter{
    
    var delegate: NoteDelegate?
    
    init(withDelegate delegate: NoteDelegate){
        self.delegate = delegate
    }
    
    func setupNote(note: Note, title: String?, body: String?){
        note.title = title
        note.body = body
        self.delegate?.notePresenter(self, didSetNote: note)
    }
}
