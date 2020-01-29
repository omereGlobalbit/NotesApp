//
//  FolderPresenter.swift
//  NotesApp
//
//  Created by Omer Elimelech on 29/01/2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import Foundation


class FoldersPresenter : BasePresenter {
    
    var delegate: FoldersDelegate?
       
       init(withDelegate delegate: FoldersDelegate){
           self.delegate = delegate
       }
       
    func selectItem(withState state: NoteState){
        self.delegate?.foldersPresenter(self, didSelectItemWithState: state)
    }
}
