//
//  NoteDelegate.swift
//  NotesApp
//
//  Created by Omer Elimelech on 29/01/2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import Foundation


protocol NoteDelegate{
    func notePresenter(_ presenter: NotePresenter, didSetNote note: Note)
}
