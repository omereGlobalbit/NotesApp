//
//  NoteViewController.swift
//  NotesApp
//
//  Created by Omer Elimelech on 29/01/2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import Foundation
import UIKit

class NoteViewController: BaseViewController {
   
    static let sbdata: sbData = (Constants.storyboardId, Constants.noteId)
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    
    var note: Note?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = NotePresenter(withDelegate: self)
        self.interactor = NoteInteractor(presenter: self.presenter as? NotePresenter)
        titleTextField.delegate = self.interactor as? NoteInteractor
        bodyTextView.delegate = self.interactor as? NoteInteractor
        self.setupData(withNote: note)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard let interactor = self.interactor as? NoteInteractor else {return}
        interactor.updateNoteIfNeeded(withTitle: self.titleTextField.text, body: self.bodyTextView.text)
        
    }
    
    func setupData(withNote note: Note?){
        guard let interactor = self.interactor as? NoteInteractor else {return}
        interactor.setupData(withNote: note)
    }
    
    
}

extension NoteViewController: NoteDelegate{
    func notePresenter(_ presenter: NotePresenter, didSetNote note: Note) {
        self.titleTextField.text = note.title
        self.bodyTextView.text = note.body
    }
}
