//
//  SBLeftRightMenuNavigationController.m
//  Menu
//
//  Created by Soumen Bhuin.
//  Copyright © 2016 SMB. All rights reserved.
//

#import "SBLeftRightMenuNavigationController.h"
#import "MenuTableViewController.h"

@interface SBLeftRightMenuNavigationController ()
@property (nonatomic, strong) UIPanGestureRecognizer *leftMenuPanGesture;
@property (nonatomic, strong) UIPanGestureRecognizer *rightMenuPanGesture;
@end

@implementation SBLeftRightMenuNavigationController

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    MenuTableViewController *menu = [self.storyboard instantiateViewControllerWithIdentifier:@"menu"];
    
    self.leftMenuController = [[SBMenuController alloc] initWithViewController:menu presentationStyle:SBMenuPresentationStyleSlideFromLeft];
    _leftMenuController.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    _leftMenuController.adjustsStatusBar = YES;
    menu.menuController = _leftMenuController;
    
    menu = [self.storyboard instantiateViewControllerWithIdentifier:@"menu"];
    
    self.rightMenuController = [[SBMenuController alloc] initWithViewController:menu presentationStyle:SBMenuPresentationStyleSlideFromRight];
    _rightMenuController.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    _rightMenuController.adjustsStatusBar = YES;
    menu.menuController = _rightMenuController;
    
    // Add PanGesture to Show SideBar by PanGesture
    UIScreenEdgePanGestureRecognizer *panGestureRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handleLeftPanGesture:)];
    panGestureRecognizer.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:panGestureRecognizer];
    _leftMenuPanGesture = panGestureRecognizer;
    
    panGestureRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handleRightPanGesture:)];
    panGestureRecognizer.edges = UIRectEdgeRight;
    [self.view addGestureRecognizer:panGestureRecognizer];
    _rightMenuPanGesture = panGestureRecognizer;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    _leftMenuController.containerRect = CGRectMake(0, 0, 230, self.view.bounds.size.height); // left
    _rightMenuController.containerRect = CGRectMake(self.view.bounds.size.width-230, 0, 230, self.view.bounds.size.height); // right
}

#pragma mark - Gesture Handler

- (void)handleLeftPanGesture:(UIPanGestureRecognizer *)recognizer {
    // if you have left and right sidebar, you can control the pan gesture by start point.
    [self.leftMenuController handleMenuPanGesture:recognizer inViewController:self];
}

- (void)handleRightPanGesture:(UIPanGestureRecognizer *)recognizer {
    // if you have left and right sidebar, you can control the pan gesture by start point.
    [self.rightMenuController handleMenuPanGesture:recognizer inViewController:self];
}

#pragma mark - Status Bar

- (nullable UIViewController *)childViewControllerForStatusBarHidden {
    
    if ([UIScreen mainScreen].bounds.size.height!=self.view.bounds.size.height) { // If personal hotspot enabled and tethering then dont hide status bar.
        return nil;
    }
    
    if (self.leftMenuController.adjustsStatusBar && [self.leftMenuController isVisible]) {
        return self.leftMenuController.contentViewController;
    }
    else if(self.rightMenuController.adjustsStatusBar && [self.rightMenuController isVisible]) {
        return self.rightMenuController.contentViewController;
    }
    return nil;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationSlide;
}

#pragma mark - Actions

- (void)setLeftMenuPanGestureEnabled:(BOOL)enabled {
    [_leftMenuPanGesture setEnabled:enabled];
}

- (void)showLeftMenuAnimated:(BOOL)animated {
    [self.leftMenuController presentInViewController:self];
}

- (void)hideLeftMenuAnimated:(BOOL)animated {
    [self.leftMenuController dismissAnimated:animated];
}

- (BOOL)isLeftMenuVisible {
    return [self.leftMenuController isVisible];
}

- (void)setRightMenuPanGestureEnabled:(BOOL)enabled {
    [_rightMenuPanGesture setEnabled:enabled];
}

- (void)showRightMenuAnimated:(BOOL)animated {
    [self.rightMenuController presentInViewController:self];
}

- (void)hideRightMenuAnimated:(BOOL)animated {
    [self.rightMenuController dismissAnimated:animated];
}

- (BOOL)isRightMenuVisible {
    return [self.rightMenuController isVisible];
}

#pragma mark -

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
