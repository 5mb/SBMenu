//
//  ViewController.m
//  Example
//
//  Created by Soumen Bhuin on 23/03/16.
//  Copyright © 2016 SMB. All rights reserved.
//

#import "LeftRightViewController.h"
#import "SBLeftRightMenuNavigationController.h"

@interface LeftRightViewController ()
@property(nullable, nonatomic,readonly,strong) SBLeftRightMenuNavigationController *navigationController;
@end

@implementation LeftRightViewController
@dynamic navigationController;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

#pragma mark - Actions

- (IBAction)btnLeftShowAction:(id)sender {
    if ([self.navigationController isLeftMenuVisible]) {
        [self.navigationController hideLeftMenuAnimated:YES];
    }
    else {
        [self.navigationController showLeftMenuAnimated:YES];
    }
}

- (IBAction)btnRightShowAction:(id)sender {
    if ([self.navigationController isRightMenuVisible]) {
        [self.navigationController hideRightMenuAnimated:YES];
    }
    else {
        [self.navigationController showRightMenuAnimated:YES];
    }
}

- (IBAction)btnDoneAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
