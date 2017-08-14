//
//  TVDataSourceDelegate.swift
//  GenericTableView
//
//  Created by Fang, Xin on 8/14/17.
//  Copyright © 2017 XFang. All rights reserved.
//

import Foundation
import UIKit


struct CellDescriptor{
    let cellClass: UITableViewCell.Type
    let reuseIdentifier: String
    let configure: (UITableViewCell) -> ()


    init<Cell: UITableViewCell>(reuseIdentifier: String, configure: @escaping (Cell) -> ()){
        self.cellClass = Cell.self
        self.reuseIdentifier = reuseIdentifier
        self.configure = { cell in
            guard ((cell as? Cell) != nil) else {
                return
            }
            configure(cell as! Cell)
        }

    }

}


class TVDataSourceDelegate<Item>: NSObject, UITableViewDataSource, UITableViewDelegate {
    let tableView: UITableView
    var dataManager : TVItemsDataManager<Item>!
    let cellDescriptor: (Item) -> CellDescriptor
    var didSelect: (Item) -> () = {_ in}
    var delegate: DataSourceNotifyViewController!


    init(_ tableView: UITableView, _ dataManager: TVItemsDataManager<Item>, cellDescriptor: @escaping (Item) -> CellDescriptor){
        self.tableView = tableView
        self.dataManager = dataManager
        self.cellDescriptor = cellDescriptor
        super.init()
        self.tableView.delegate = self
        self.tableView.dataSource = self

    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataManager.items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = dataManager.items[indexPath.row]
        let descriptor = cellDescriptor(item)

        let cell = tableView.dequeueReusableCell(withIdentifier: descriptor.reuseIdentifier, for: indexPath)
        descriptor.configure(cell)
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let communityItem = dataManager.items[indexPath.row]
        didSelect(communityItem)
    }
}


protocol DataSourceNotifyViewController {
    func tableViewReloadItems()
    func tableViewLoadMoreItems()
}




