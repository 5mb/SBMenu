//
//  SBTopBottomMenuNavigationController.h
//  Menu
//
//  Created by Soumen Bhuin.
//  Copyright © 2016 SMB. All rights reserved.
//

#import <SBMenu/SBMenu.h>

@interface SBTopBottomMenuNavigationController : UINavigationController

@property (nonatomic, strong) SBMenuController *topMenuController;
@property (nonatomic, strong) SBMenuController *bottomMenuController;

- (void)setTopMenuPanGestureEnabled:(BOOL)enabled;
- (void)showTopMenuAnimated:(BOOL)animated;
- (void)hideTopMenuAnimated:(BOOL)animated;
- (BOOL)isTopMenuVisible;

- (void)setBottomMenuPanGestureEnabled:(BOOL)enabled;
- (void)showBottomMenuAnimated:(BOOL)animated;
- (void)hideBottomMenuAnimated:(BOOL)animated;
- (BOOL)isBottomMenuVisible;

@end
