//
//  SBLeftRightMenuNavigationController.swift
//  SwiftExample
//
//  Created by Soumen Bhuin on 07/01/20.
//  Copyright © 2020 smbhuin. All rights reserved.
//

import UIKit
import SBSideMenu

class SBLeftRightMenuNavigationController: UINavigationController {
    
    var leftMenuController: SBMenuController? = nil
    var rightMenuController: SBMenuController? = nil
    
    var leftMenuPanGesture: UIScreenEdgePanGestureRecognizer? = nil
    var rightMenuPanGesture: UIScreenEdgePanGestureRecognizer? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let leftMenu = self.storyboard?.instantiateViewController(withIdentifier: "menu") as! MenuTableViewController
        leftMenuController = SBMenuController(viewController: leftMenu, presentationStyle: SBMenuPresentationStyleSlideFromLeft)
        leftMenuController?.backgroundColor = UIColor(white: 0.0, alpha: 0.5);
        leftMenuController?.adjustsStatusBar = true;
        leftMenu.menuController = leftMenuController;
        
        
        let rightMenu = self.storyboard?.instantiateViewController(withIdentifier: "menu") as! MenuTableViewController
        rightMenuController = SBMenuController(viewController: rightMenu, presentationStyle: SBMenuPresentationStyleSlideFromRight)
        rightMenuController?.backgroundColor = UIColor(white: 0.0, alpha: 0.5);
        rightMenuController?.adjustsStatusBar = false;
        rightMenu.menuController = rightMenuController;
        
        // Add PanGesture to Show SideBar by PanGesture
        leftMenuPanGesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(self.handleLeftPanGesture))
        leftMenuPanGesture?.edges = .left
        self.view.addGestureRecognizer(leftMenuPanGesture!)
        
        rightMenuPanGesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(self.handleRightPanGesture))
        rightMenuPanGesture?.edges = .right;
        self.view.addGestureRecognizer(rightMenuPanGesture!)
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        leftMenuController?.containerRect = CGRect(x:0, y:0, width:230, height:self.view.bounds.size.height); // left
        rightMenuController?.containerRect = CGRect(x:self.view.bounds.size.width-230, y:0, width:230, height:self.view.bounds.size.height); // right
    }
    
    @objc func handleLeftPanGesture(_ gesture: UIPanGestureRecognizer) {
        self.leftMenuController?.handleMenuPanGesture(gesture, in: self)
    }
    
    @objc func handleRightPanGesture(_ gesture: UIPanGestureRecognizer) {
        self.rightMenuController?.handleMenuPanGesture(gesture, in: self)
    }
    
    override var childForStatusBarHidden: UIViewController? {
        if UIScreen.main.bounds.size.height != self.view.bounds.size.height { // If personal hotspot enabled and tethering then dont hide status bar.
            return nil;
        }
        if self.leftMenuController!.adjustsStatusBar && self.leftMenuController!.isVisible {
            return self.leftMenuController!.contentViewController;
        }
        else if self.rightMenuController!.adjustsStatusBar && self.rightMenuController!.isVisible {
            return self.rightMenuController!.contentViewController;
        }
        return nil;
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
    
    var leftMenuPanGestureEnabled: Bool {
        set {
            self.leftMenuPanGesture?.isEnabled = leftMenuPanGestureEnabled
        }
        get {
            return self.leftMenuPanGesture?.isEnabled ?? false
        }
    }
    
    func showLeftMenu(animated: Bool) {
        self.leftMenuController?.present(in: self)
    }
    
    func hideLeftMenu(animated: Bool) {
        self.leftMenuController?.dismiss(animated: animated)
    }
    
    func isLeftMenuVisible() -> Bool {
        return self.leftMenuController?.isVisible ?? false
    }
    
    var rightMenuPanGestureEnabled: Bool {
        set {
            self.rightMenuPanGesture?.isEnabled = rightMenuPanGestureEnabled
        }
        get {
            return self.rightMenuPanGesture?.isEnabled ?? false
        }
    }
    
    func showRightMenu(animated: Bool) {
        self.rightMenuController?.present(in: self)
    }
    
    func hideRightMenu(animated: Bool) {
        self.rightMenuController?.dismiss(animated: animated)
    }
    
    func isRightMenuVisible() -> Bool {
        return self.rightMenuController?.isVisible ?? false
    }

}

extension UIViewController {
    var menuNavigationController: SBLeftRightMenuNavigationController? {
        return self.navigationController as? SBLeftRightMenuNavigationController
    }
}
