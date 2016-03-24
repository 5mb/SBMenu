//
//  PopViewController.m
//  Example
//
//  Created by Soumen Bhuin on 23/03/16.
//  Copyright © 2016 SMB. All rights reserved.
//

#import "PopViewController.h"
#import <SBMenu/SBMenu.h>

#import "MenuTableViewController.h"

@interface PopViewController ()
@property (nonatomic, strong) SBMenuController *menuController;
@end

@implementation PopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    MenuTableViewController *menu = [self.storyboard instantiateViewControllerWithIdentifier:@"menu"];
    
    self.menuController = [[SBMenuController alloc] initWithViewController:menu presentationStyle:SBMenuPresentationStyleFadeIn];
    _menuController.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    _menuController.adjustsStatusBar = NO;
    menu.menuController = _menuController;
    
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    _menuController.containerRect = CGRectMake(([UIScreen mainScreen].bounds.size.width-200)/2, ([UIScreen mainScreen].bounds.size.height-300)/2, 200, 300);
    
}

#pragma mark - Actions

- (IBAction)btnShowAction:(id)sender {
    if ([self.menuController isVisible]) {
        [self.menuController dismissAnimated:YES];
    }
    else {
        [self.menuController presentInViewController:self];
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
