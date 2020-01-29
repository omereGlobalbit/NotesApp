//
//  BaseViewController.swift
//  NotesApp
//
//  Created by Omer Elimelech on 29/01/2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import Foundation
import UIKit

typealias sbData = (storyboardName: String, storyboardId: String)
public class BaseViewController: UIViewController{
    
    var presenter: BasePresenter?
    
    var interactor: BaseInteractor?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    func navigate(_ navigation: NotesNavigation) {
        Router.default.navigate(navigation, from: self)
    }
    
    static func initialize<T: UIViewController>(data: sbData, type : T.Type) -> T{
        guard let vc = UIStoryboard(name: data.storyboardName, bundle: nil).instantiateViewController(withIdentifier: data.storyboardId) as? T else {return UIViewController() as! T}
        return vc
    }
}


