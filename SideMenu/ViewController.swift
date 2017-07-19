//
//  ViewController.swift
//  SideMenu
//
//  Created by Fang, Xin on 7/19/17.
//  Copyright © 2017 XFang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var sideMenuTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.sideMenuTableView.delegate = self
        self.sideMenuTableView.dataSource = self
        self.slideMenuController()?.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SideMenuTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SideMenuTableViewCell") as! SideMenuTableViewCell

        cell.label.text = "\(indexPath.row)"

        return cell
    }
}

extension ViewController:  SlideMenuControllerDelegate {
    func leftWillOpen() {
        print("leftWillOpen")
        self.slideMenuController()?.mainContainerView.isUserInteractionEnabled = false
    }
    func leftWillClose() {
        print("")
        self.slideMenuController()?.mainContainerView.isUserInteractionEnabled = true
    }

}

