//
//  TVItemsDataManager.swift
//  GenericTableView
//
//  Created by Fang, Xin on 8/14/17.
//  Copyright © 2017 XFang. All rights reserved.
//

import Foundation

class TVItemsDataManager<Item> {
    
    var items = [Item]()
    func appendItems(_ newItems: [Item]){
        self.items.append(contentsOf: newItems)

    }
}
