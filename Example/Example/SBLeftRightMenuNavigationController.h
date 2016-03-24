//
//  SBLeftRightMenuNavigationController.h
//  Menu
//
//  Created by Soumen Bhuin.
//  Copyright © 2016 SMB. All rights reserved.
//

#import <SBMenu/SBMenu.h>

@interface SBLeftRightMenuNavigationController : UINavigationController

@property (nonatomic, strong) SBMenuController *leftMenuController;
@property (nonatomic, strong) SBMenuController *rightMenuController;

- (void)setLeftMenuPanGestureEnabled:(BOOL)enabled;
- (void)showLeftMenuAnimated:(BOOL)animated;
- (void)hideLeftMenuAnimated:(BOOL)animated;
- (BOOL)isLeftMenuVisible;

- (void)setRightMenuPanGestureEnabled:(BOOL)enabled;
- (void)showRightMenuAnimated:(BOOL)animated;
- (void)hideRightMenuAnimated:(BOOL)animated;
- (BOOL)isRightMenuVisible;

@end
