//
//  MenuTableViewController.swift
//  SwiftExample
//
//  Created by Soumen Bhuin on 07/01/20.
//  Copyright © 2020 smbhuin. All rights reserved.
//

import UIKit
import SBSideMenu

class MenuTableViewController: UITableViewController {
    
    weak var menuController: SBMenuController? = nil
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView?.frame = CGRect(x:0, y:0, width:self.view.bounds.size.width, height:self.view.bounds.size.height-278-44)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        if cell.selectedBackgroundView == nil {
            cell.selectedBackgroundView = UIView()
            cell.selectedBackgroundView?.backgroundColor = UIColor.red
        }
        return cell;
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let pvc = self.parent as? UINavigationController {
            self.menuController?.dismiss(animated: true, completion: {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "next")
                pvc.pushViewController(vc!, animated: true)
            })
        }
    }

}

