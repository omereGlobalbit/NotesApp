
//
//  NotesDelegate.swift
//  NotesApp
//
//  Created by Omer Elimelech on 29/01/2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import Foundation


protocol NotesDelegate {
    func notesPresenter(_ presenter: NotesPresenter, didFetchNotes notes: [Note]?)
    func notesPresenter(_ presenter: NotesPresenter, didFailToFetchNotesWithError error: Error)
    func notesPresenter(_ presenter: NotesPresenter, didSelectNote note: Note, at indexPath: IndexPath)
}
