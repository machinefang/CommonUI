//
//  ViewController.swift
//  GenericTableView
//
//  Created by Fang, Xin on 8/14/17.
//  Copyright © 2017 XFang. All rights reserved.
//

import UIKit

struct MyItem {
    var content = 0
}


extension MyItem {
    func configureCell (_ cell : MyItemTableViewCell){
        cell.contentLabel.text = "\(self.content)"
    }
    func descriptCell() -> CellDescriptor{
        return CellDescriptor(reuseIdentifier: "MyItemTableViewCell", configure: self.configureCell)
    }
}

class MyItemDataManager: TVItemsDataManager<MyItem>{

    func getData() {
        self.items = Array(repeating: MyItem(content: 0), count: 10)
    }
}


class ViewController: UIViewController {
    @IBOutlet weak var myTableView: UITableView!
    var dataService: TVDataSourceDelegate<MyItem>?
    var dataManager = MyItemDataManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableViewDataServiceSetup()
        self.tableViewDataManagerSetup()
        // Do any additional setup after loading the view, typically from a nib.
    }

    func tableViewDataServiceSetup(){
        self.dataService = TVDataSourceDelegate(myTableView, dataManager, cellDescriptor: {$0.descriptCell()})
        guard let dataService = self.dataService else {
        return
        }

        self.myTableView.dataSource = dataService
        self.myTableView.delegate = dataService

        self.dataService?.didSelect = {myItem in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "DetailViewController")
            self.present(controller, animated: true, completion: nil)

        }

    }

    func tableViewDataManagerSetup(){
        self.dataManager.getData()

    }

}

