//
//  SBTopBottomMenuNavigationController.m
//  Example
//
//  Created by Soumen Bhuin.
//  Copybottom © 2016 smbhuin. All bottoms reserved.
//

#import "SBTopBottomMenuNavigationController.h"
#import "MenuTableViewController.h"

@interface SBTopBottomMenuNavigationController ()
@property (nonatomic, strong) UIPanGestureRecognizer *topMenuPanGesture;
@property (nonatomic, strong) UIPanGestureRecognizer *bottomMenuPanGesture;
@end

@implementation SBTopBottomMenuNavigationController

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    MenuTableViewController *menu = [self.storyboard instantiateViewControllerWithIdentifier:@"menu"];
    
    self.topMenuController = [[SBMenuController alloc] initWithViewController:menu presentationStyle:SBMenuPresentationStyleSlideFromTop];
    _topMenuController.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    _topMenuController.adjustsStatusBar = NO;
    menu.menuController = _topMenuController;
    
    menu = [self.storyboard instantiateViewControllerWithIdentifier:@"menu"];
    
    self.bottomMenuController = [[SBMenuController alloc] initWithViewController:menu presentationStyle:SBMenuPresentationStyleSlideFromBottom];
    _bottomMenuController.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    _bottomMenuController.adjustsStatusBar = NO;
    menu.menuController = _bottomMenuController;
    
    // Add PanGesture to Show SideBar by PanGesture
    UIScreenEdgePanGestureRecognizer *panGestureRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handletopPanGesture:)];
    panGestureRecognizer.edges = UIRectEdgeTop;
    [self.view addGestureRecognizer:panGestureRecognizer];
    _topMenuPanGesture = panGestureRecognizer;
    
    panGestureRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handlebottomPanGesture:)];
    panGestureRecognizer.edges = UIRectEdgeBottom;
    [self.view addGestureRecognizer:panGestureRecognizer];
    _bottomMenuPanGesture = panGestureRecognizer;
}

/*- (UIBarPosition)positionForBar:(id <UIBarPositioning>)bar {
 return UIBarPositionTopAttached;
 }*/

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    _topMenuController.containerRect = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 300); // top
    _bottomMenuController.containerRect = CGRectMake(0, [UIScreen mainScreen].bounds.size.height-300, [UIScreen mainScreen].bounds.size.width, 300); // bottom
}

#pragma mark - Gesture Handler

- (void)handletopPanGesture:(UIPanGestureRecognizer *)recognizer {
    // if you have top and bottom sidebar, you can control the pan gesture.
    [self.topMenuController handleMenuPanGesture:recognizer inViewController:self];
}

- (void)handlebottomPanGesture:(UIPanGestureRecognizer *)recognizer {
    // if you have top and bottom sidebar, you can control the pan gesture.
    [self.bottomMenuController handleMenuPanGesture:recognizer inViewController:self];
}

#pragma mark - Status Bar

- (nullable UIViewController *)childViewControllerForStatusBarHidden {
    
    if (self.topMenuController.adjustsStatusBar && [self.topMenuController isVisible]) {
        return self.topMenuController.contentViewController;
    }
    else if(self.bottomMenuController.adjustsStatusBar && [self.bottomMenuController isVisible]) {
        return self.bottomMenuController.contentViewController;
    }
    return nil;
}

#pragma mark - Actions

- (void)setTopMenuPanGestureEnabled:(BOOL)enabled {
    [_topMenuPanGesture setEnabled:enabled];
}

- (void)showTopMenuAnimated:(BOOL)animated {
    [self.topMenuController presentInViewController:self];
}

- (void)hideTopMenuAnimated:(BOOL)animated {
    [self.topMenuController dismissAnimated:animated];
}

- (BOOL)isTopMenuVisible {
    return [self.topMenuController isVisible];
}

- (void)setBottomMenuPanGestureEnabled:(BOOL)enabled {
    [_bottomMenuPanGesture setEnabled:enabled];
}

- (void)showBottomMenuAnimated:(BOOL)animated {
    [self.bottomMenuController presentInViewController:self];
}

- (void)hideBottomMenuAnimated:(BOOL)animated {
    [self.bottomMenuController dismissAnimated:animated];
}

- (BOOL)isBottomMenuVisible {
    return [self.bottomMenuController isVisible];
}

#pragma mark -

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
