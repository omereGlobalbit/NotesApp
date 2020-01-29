//
//  FoldersViewController.swift
//  NotesApp
//
//  Created by Omer Elimelech on 29/01/2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import Foundation
import UIKit



class FoldersViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = FoldersPresenter(withDelegate: self)
        self.interactor = FoldersIntercator(presenter: self.presenter as? FoldersPresenter)
        tableView.delegate = self.interactor as? FoldersIntercator
        tableView.dataSource = self.interactor as? FoldersIntercator
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.cellReuseId)
    }
    
}

extension FoldersViewController: FoldersDelegate {
    func foldersPresenter(_ presenter: FoldersPresenter, didSelectItemWithState state: NoteState) {
        navigate(.notesPage(state: state))
    }
    
    
}

