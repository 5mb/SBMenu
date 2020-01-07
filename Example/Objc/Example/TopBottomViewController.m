//
//  TopBottomViewController.m
//  Example
//
//  Created by Soumen Bhuin on 23/03/16.
//  Copyright © 2016 smbhuin. All rights reserved.
//

#import "TopBottomViewController.h"
#import "SBTopBottomMenuNavigationController.h"

@interface TopBottomViewController ()
@property(nullable, nonatomic,readonly,strong) SBTopBottomMenuNavigationController *navigationController;
@end

@implementation TopBottomViewController
@dynamic navigationController;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

#pragma mark - Actions

- (IBAction)btnTopShowAction:(id)sender {
    if ([self.navigationController isTopMenuVisible]) {
        [self.navigationController hideTopMenuAnimated:YES];
    }
    else {
        [self.navigationController showTopMenuAnimated:YES];
    }
}

- (IBAction)btnButtomShowAction:(id)sender {
    if ([self.navigationController isBottomMenuVisible]) {
        [self.navigationController hideBottomMenuAnimated:YES];
    }
    else {
        [self.navigationController showBottomMenuAnimated:YES];
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
