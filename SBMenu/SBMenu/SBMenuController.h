//
//  SBMenuController.h
//  SBMenu
//
//  Created by Soumen Bhuin.
//  Copyright © 2016 SMB. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    SBMenuPresentationStyleSlideFromTop,
    SBMenuPresentationStyleSlideFromLeft,
    SBMenuPresentationStyleSlideFromBottom,
    SBMenuPresentationStyleSlideFromRight,
    SBMenuPresentationStyleFadeIn
} SBMenuPresentationStyle;

@interface SBMenuController : NSObject

@property (nonatomic, strong, readonly, nonnull) UIView *containerView; // contains the presented view controller's view.
@property (nonatomic, strong, readonly, nullable) UIView *contentBackgroundView; //default one has the shadow
@property (nonatomic, strong, readonly, nonnull) UIViewController *contentViewController; // to be presented.
@property (nonatomic, weak, readonly, nullable) UIViewController *presentingViewController;
@property (nonatomic, strong, readonly, nonnull) UITapGestureRecognizer *tapGestureRecognizer;
@property (nonatomic, strong, readonly, nonnull) UIPanGestureRecognizer *panGestureRecognizer;
@property (nonatomic, assign) BOOL showShadow; // Default: YES // Shadow will be applied on content background view, If yes then background view is lazily created.
@property (nonatomic, assign) UIViewAutoresizing contentViewResizingMask;
@property (nonatomic, assign) CGRect containerRect; // rect in parent view controller's view.
@property (nonatomic, assign, readonly) SBMenuPresentationStyle presentationStyle; // How the menu will be presented.
@property (nonatomic, assign) NSTimeInterval animationDuration;
@property (nonatomic, assign) BOOL adjustsStatusBar; // Just request to update status bar with animation!
@property (nonatomic, strong, nullable) UIColor *backgroundColor;
@property (nonatomic, assign, readonly, getter=isVisible) BOOL visible;
@property (nonatomic, copy, nullable) void (^onCompletion)(void);
           
- (nonnull instancetype)initWithViewController:(nonnull UIViewController *)viewController presentationStyle:(SBMenuPresentationStyle)style; // view controller to be presented.
- (void)handleMenuPanGesture:(nonnull UIPanGestureRecognizer *)gesture inViewController:(nonnull UIViewController *)viewController;
- (void)presentInViewController:(nonnull UIViewController *)viewController; //animated
- (void)presentInViewController:(nonnull UIViewController *)viewController animated:(BOOL)animated;
- (void)presentInViewController:(nonnull UIViewController *)viewController animated:(BOOL)animated completion:(void (^ __nullable)(void))completion;
- (void)dismissAnimated:(BOOL)animated;
- (void)dismissAnimated:(BOOL)animated completion:(void (^ __nullable)(void))completion;

@end
