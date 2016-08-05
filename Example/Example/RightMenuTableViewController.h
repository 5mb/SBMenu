//
//  RightMenuTableViewController.h
//  Example
//
//  Created by Soumen Bhuin on 05/08/16.
//  Copyright © 2016 SMB. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SBMenuController;
@interface RightMenuTableViewController : UITableViewController
@property (nonatomic, weak) SBMenuController *menuController;
@end
