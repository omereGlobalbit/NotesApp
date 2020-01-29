//
//  NoteInteractor.swift
//  NotesApp
//
//  Created by Omer Elimelech on 29/01/2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import Foundation
import UIKit


class NoteInteractor: BaseInteractor {
    
    var presenter: NotePresenter?
    
    var note: Note?
    var worker = NotesWorker()
    init(presenter: NotePresenter?){
        super.init()
        self.presenter = presenter
    }
    
    func setupData(withNote note: Note?){
        guard let note = note else {
            if let newNote = worker.createNewNote(){
                self.note = newNote
                self.presenter?.setupNote(note: newNote, title: nil, body: Constants.bodyPlaceHolder)
            }
            return
        }
        self.note = note
        self.presenter?.setupNote(note: note, title: note.title, body: note.body)
    }
    
    func updateNoteIfNeeded(withTitle title: String?, body: String){
        guard let note = self.note else {return}
        if (title == nil || title == "") && body == Constants.bodyPlaceHolder {
            self.worker.deleteNote(note: note)
            return
        }
        let fixedTitle = title == "" ? Constants.untitledNote : title
        self.worker.saveNote(note: note, title: fixedTitle ?? Constants.untitledNote , body: body)
    }

}


extension NoteInteractor: UITextViewDelegate{
   
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == Constants.bodyPlaceHolder{
            textView.text?.removeAll()
        }
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        worker.updateNote(note: self.note, withValue: textView.text, forKey: Constants.body)
        return true
    }
}


extension NoteInteractor: UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text == Constants.untitledNote{
            textField.text?.removeAll()
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        worker.updateNote(note: self.note, withValue: textField.text, forKey: Constants.title)
        return true
    }
}

