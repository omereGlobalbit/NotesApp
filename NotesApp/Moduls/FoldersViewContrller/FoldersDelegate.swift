//
//  FoldersDelegate.swift
//  NotesApp
//
//  Created by Omer Elimelech on 29/01/2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import Foundation



protocol FoldersDelegate{
    
    func foldersPresenter(_ presenter: FoldersPresenter, didSelectItemWithState state: NoteState)
    
}
