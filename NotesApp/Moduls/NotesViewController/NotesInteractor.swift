//
//  NotesInteractor.swift
//  NotesApp
//
//  Created by Omer Elimelech on 29/01/2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import Foundation
import SwipeCellKit


class NotesInteractor: BaseInteractor {
    
    var notes: [Note]?
    
    weak var presenter: NotesPresenter?
    
    var state: NoteState?
    
    var worker = NotesWorker()
    
    final let predicateFormat = "\(Constants.isRecycled) = %d"
    let cellHeight: CGFloat = 65
    
    init(presenter: NotesPresenter?){
        super.init()
        self.presenter = presenter
        
    }
    
    func setupData(forState state: NoteState){
        self.state = state
        let predicate = NSPredicate(format: predicateFormat, (state == .main ? false : true) as CVarArg)
        CoreDataManager.shared.get(type: Note.self, entityName: Constants.note, predicate: predicate, completion: { (result) in
            self.presenter?.handleNotesResult(result: result)
        })
    }
    
    private func removeAndReload(tableView: UITableView, at indexPath: IndexPath){
               self.notes?.remove(at: indexPath.row)
               tableView.reloadData()
    }
    
}

extension NotesInteractor: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellReuseId, for: indexPath) as? SwipeTableViewCell else {return UITableViewCell()}
        
        cell.textLabel?.text = self.notes?[indexPath.item].value(forKey: Constants.title) as? String
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.notes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let state = self.state, let note = notes?[indexPath.row] else {return}
        switch state {
        case .main:
            self.presenter?.selectNote(note: note, at: indexPath)
        case .recycleBin:
            guard let cell = tableView.cellForRow(at: indexPath) as? SwipeTableViewCell else {return}
            cell.showSwipe(orientation: .right)
        }
    }
    
       
}
extension NotesInteractor: SwipeTableViewCellDelegate {
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right, let state = state, let note = self.notes?[indexPath.row] else {return nil}
        // state = recycle - delete, restore
        // state = main - archive, edit
        
        let archiveButton = setupSwipableButton(style: .default, title: Constants.archive, withColor: .blue, imageName: Constants.archiveBox, indexPath: indexPath) { [weak self] (action, indexPath) in
            guard let strongSelf = self else {return}
            strongSelf.worker.archiveNote(note: note)
            strongSelf.removeAndReload(tableView: tableView, at: indexPath)
            action.fulfill(with: .delete)
        }
        
        let editButton = setupSwipableButton(style: .default, title: Constants.edit, withColor: .orange, imageName: Constants.pencil, indexPath: indexPath) { (action, indexPath) in
            self.presenter?.selectNote(note: note, at: indexPath)
        }
        let deleteButton = setupSwipableButton(style: .destructive, title: Constants.delete, withColor: .red, imageName: Constants.trash, indexPath: indexPath) { [weak self] (action, indexPath) in
            guard let strongSelf = self else {return}
            strongSelf.worker.deleteNote(note: note)
            strongSelf.removeAndReload(tableView: tableView, at: indexPath)
            action.fulfill(with: .delete)
            
        }
        let restoreButton = setupSwipableButton(style: .default, title: Constants.restore, withColor: .orange, imageName: Constants.restoreArrow, indexPath: indexPath) { [weak self] (action, indexPath) in
            guard let strongSelf = self else {return}
            strongSelf.worker.restoreNote(note: note)
            strongSelf.removeAndReload(tableView: tableView, at: indexPath)
            action.fulfill(with: .delete)
        }
        
        switch state {
        case .main:
            return [archiveButton, editButton]
        case .recycleBin:
            return [deleteButton, restoreButton]
        }
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.transitionStyle = .border
        return options
    }
    private func setupSwipableButton(style: SwipeActionStyle, title: String, withColor color: UIColor, imageName name: String, indexPath: IndexPath, handler: ((SwipeAction, IndexPath) -> Void)?) -> SwipeAction{
        let button = SwipeAction(style: style, title: title, handler: handler)
        button.backgroundColor = color
        button.image = UIImage(systemName: name)
        button.hidesWhenSelected = true
        return button
    }
}
