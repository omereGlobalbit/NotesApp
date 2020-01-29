//
//  NotesAppNavigation.swift
//  NotesApp
//
//  Created by Omer Elimelech on 29/01/2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import Foundation
import UIKit

struct NotesAppNavigation: AppNavigation {
    func viewcontrollerForNavigation(navigation: Navigation) -> UIViewController {
        guard let navigation = navigation as? NotesNavigation else {return UIViewController()}
        switch navigation {
        case .notesPage(let state):
            let vc = BaseViewController.initialize(data: NotesViewController.sbdata, type: NotesViewController.self)
            vc.currentState = state
            return vc
            
        case .notePage(let note):
            let vc = BaseViewController.initialize(data: NoteViewController.sbdata, type: NoteViewController.self)
            vc.note = note
            return vc
        }
    }
    
    func navigate(_ navigation: Navigation, from: UIViewController, to: UIViewController) {
        from.navigationController?.pushViewController(to, animated: true)
    }
    
    
}
