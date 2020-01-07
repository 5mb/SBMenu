//
//  RightMenuTableViewController.m
//  Example
//
//  Created by Soumen Bhuin on 05/08/16.
//  Copyright © 2016 smbhuin. All rights reserved.
//

#import "RightMenuTableViewController.h"
#import "SBLeftRightMenuNavigationController.h"
#import "SBTopBottomMenuNavigationController.h"

@interface RightMenuTableViewController ()
@end

@implementation RightMenuTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UINavigationController *pvc = (UINavigationController *)self.navigationController;
    UIViewController *VC = [self.storyboard instantiateViewControllerWithIdentifier:@"nextmenuvc"];
    [pvc pushViewController:VC animated:YES];
}

@end
