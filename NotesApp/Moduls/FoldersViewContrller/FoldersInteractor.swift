//
//  FoldersInteractor.swift
//  NotesApp
//
//  Created by Omer Elimelech on 29/01/2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import Foundation
import UIKit


class FoldersIntercator : BaseInteractor{
    
    var dataSource = [ (title: Constants.notes, image: Constants.docTextFill), (title: Constants.archives, image:  Constants.archiveBox)]
    
    var presenter: FoldersPresenter?
    
    init(presenter: FoldersPresenter?){
          super.init()
          self.presenter = presenter
    }

}

extension FoldersIntercator: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellReuseId, for: indexPath)
        cell.tintColor = .orange
        cell.imageView?.image = UIImage(systemName: dataSource[indexPath.item].image)
        cell.textLabel?.text = dataSource[indexPath.item].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.item{
        case 0:
            self.presenter?.selectItem(withState: .main)
        case 1:
            self.presenter?.selectItem(withState: .recycleBin)
        default:
            return
        }
    }
}
