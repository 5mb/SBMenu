//
//  MenuTableViewController.h
//  Example
//
//  Created by Soumen Bhuin on 23/03/16.
//  Copyright © 2016 SMB. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SBMenuController;

@interface MenuTableViewController : UITableViewController
@property (nonatomic, weak) SBMenuController *menuController;
@end
