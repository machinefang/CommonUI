//
//  MainViewController.swift
//  SideMenu
//
//  Created by Fang, Xin on 7/19/17.
//  Copyright © 2017 XFang. All rights reserved.
//

import UIKit

class MainContainerVC: SlideMenuController {

    override func awakeFromNib() {

        guard let sideMenu = self.storyboard?.instantiateViewController(withIdentifier: "SideMenuViewController") else {
            fatalError("")
        }

        self.leftViewController = sideMenu

        guard let nav = self.storyboard?.instantiateViewController(withIdentifier: "Home") as? UINavigationController else {
            fatalError("")

        }
        self.mainViewController = nav

        super.awakeFromNib()
    }

    

}
