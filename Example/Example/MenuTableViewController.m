//
//  MenuTableViewController.m
//  Example
//
//  Created by Soumen Bhuin on 23/03/16.
//  Copyright © 2016 SMB. All rights reserved.
//

#import "MenuTableViewController.h"
#import "SBLeftRightMenuNavigationController.h"
#import "SBTopBottomMenuNavigationController.h"

@interface MenuTableViewController ()
@end

@implementation MenuTableViewController
@dynamic parentViewController;

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationSlide;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-232-44);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    if (cell.selectedBackgroundView==nil) {
        cell.selectedBackgroundView = [[UIView alloc] init];
        cell.selectedBackgroundView.backgroundColor = [UIColor redColor];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UINavigationController *pvc = (UINavigationController *)self.parentViewController;
    
    [self.menuController dismissAnimated:YES completion:^{
        if ([pvc isKindOfClass:[UINavigationController class]]) {
            UIViewController *VC = [self.storyboard instantiateViewControllerWithIdentifier:@"next"];
            [pvc pushViewController:VC animated:YES];
        }
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
