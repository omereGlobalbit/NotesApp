//
//NotesViewController.swift
//  NotesApp
//
//  Created by Omer Elimelech on 29/01/2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import UIKit
import CoreData
import SwipeCellKit

class NotesViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    var notes: [Note]?
    static let sbdata: sbData = (Constants.storyboardId, Constants.notesId)
    
    var currentState: NoteState?


    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(SwipeTableViewCell.self, forCellReuseIdentifier: Constants.cellReuseId)
        self.presenter = NotesPresenter(withDelegate: self)
        self.interactor = NotesInteractor(presenter: self.presenter as? NotesPresenter)
        tableView.delegate = self.interactor as? NotesInteractor
        tableView.dataSource = self.interactor as? NotesInteractor
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let interactor = self.interactor as? NotesInteractor, let state = self.currentState else {return}
        interactor.setupData(forState: state)
        self.title = state == .main ? Constants.notes : Constants.archives
    }
    
   @IBAction func newNoteTapped(_ sender: UIBarButtonItem) {
       navigate(.notePage(note: nil))
   }
    
}



extension NotesViewController: NotesDelegate {
    func notesPresenter(_ presenter: NotesPresenter, didSelectNote note: Note, at indexPath: IndexPath) {
        self.navigate(.notePage(note: note))
    }
    
    func notesPresenter(_ presenter: NotesPresenter, didFetchNotes notes: [Note]?) {
        guard let interactor = self.interactor as? NotesInteractor else {return}
        interactor.notes = notes
        self.tableView.reloadData()
    }
    
    func notesPresenter(_ presenter: NotesPresenter, didFailToFetchNotesWithError error: Error) {
        //alert
    }
    
    
}


