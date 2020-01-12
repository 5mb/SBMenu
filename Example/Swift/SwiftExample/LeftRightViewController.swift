//
//  LeftRightViewController.swift
//  SwiftExample
//
//  Created by Soumen Bhuin on 07/01/20.
//  Copyright © 2020 smbhuin. All rights reserved.
//

import UIKit

class LeftRightViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func btnLeftAction(_ sender: Any) {
        if let nvc = self.navigationController as? SBLeftRightMenuNavigationController {
            nvc.showLeftMenu(animated: true)
        }
    }
    
    @IBAction func btnRightAction(_ sender: Any) {
        self.menuNavigationController?.showRightMenu(animated: true)
    }
    
    @IBAction func btnDoneAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
