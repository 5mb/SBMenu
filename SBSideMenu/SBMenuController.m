//
//  SBMenuController.m
//  SBSideMenu
//
//  Created by Soumen Bhuin.
//  Copyright © 2016 smbhuin. All rights reserved.
//

#import "SBMenuController.h"

@interface SBMenuController () <UIGestureRecognizerDelegate>
@property (nonatomic, assign, readwrite, getter=isVisible) BOOL visible;
@property (nonatomic, strong, readwrite) UIView *containerView;
@property (nonatomic, strong, readwrite) UIViewController *contentViewController;
@property (nonatomic, weak, readwrite) UIViewController *presentingViewController;
@property (nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;
@property (nonatomic, strong, readwrite) UIPanGestureRecognizer *panGestureRecognizer;
@property (nonatomic, assign) CGPoint panStartPoint;
@property (nonatomic, assign) CGRect panStartContentRect;
@property (nonatomic, assign) CGFloat backgroundColorAlpha;
@end

@implementation SBMenuController

- (nonnull instancetype)initWithViewController:(nonnull UIViewController *)viewController presentationStyle:(SBMenuPresentationStyle)style {
    if (self = [super init]) {
        _presentationStyle = style;
        self.contentViewController = viewController;
        self.containerView = [[UIView alloc] init];
        _containerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _animationDuration = 0.3;
        _showShadow = YES;
        _adjustsStatusBar = YES;
        self.tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
        _tapGestureRecognizer.delegate = self;
        [_containerView addGestureRecognizer:_tapGestureRecognizer];
        self.panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
        _panGestureRecognizer.minimumNumberOfTouches = 1;
        _panGestureRecognizer.maximumNumberOfTouches = 1;
        _panGestureRecognizer.enabled = YES;
        [_containerView addGestureRecognizer:self.panGestureRecognizer];
    }
    return self;
}

- (CGRect)preOrPostAnimationContentRect {
    CGFloat tempY = _containerRect.origin.y;
    CGFloat tempX = _containerRect.origin.x;
    switch (_presentationStyle) {
        case SBMenuPresentationStyleSlideFromTop:
            tempY = [UIScreen mainScreen].bounds.origin.y-_containerRect.size.height;
            break;
        case SBMenuPresentationStyleSlideFromLeft:
            tempX = [UIScreen mainScreen].bounds.origin.x-_containerRect.size.width;
            break;
        case SBMenuPresentationStyleSlideFromBottom:
            tempY = [UIScreen mainScreen].bounds.size.height;
            break;
        case SBMenuPresentationStyleSlideFromRight:
            tempX = [UIScreen mainScreen].bounds.size.width;
            break;
        default:
            break;
    }
    return CGRectMake(tempX, tempY, _containerRect.size.width, _containerRect.size.height);
}

- (UIViewAutoresizing)contentViewAutoresizingMask {
    UIViewAutoresizing tarm = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    switch (_presentationStyle) {
        case SBMenuPresentationStyleSlideFromTop:
            tarm = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleWidth;
            break;
        case SBMenuPresentationStyleSlideFromLeft:
            tarm = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleHeight;
            break;
        case SBMenuPresentationStyleSlideFromBottom:
            tarm = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleWidth;
            break;
        case SBMenuPresentationStyleSlideFromRight:
            tarm = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleHeight;
            break;
        default:
            break;
    }
    return tarm;
}

- (void)presentInViewController:(UIViewController *)viewController {
    [self presentInViewController:viewController animated:YES];
}

- (void)presentInViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [self presentInViewController:viewController animated:animated completion:nil];
}

- (void)presentInViewController:(nonnull UIViewController *)viewController animated:(BOOL)animated completion:(void (^ __nullable)(void))completion {
    [self addInViewController:viewController];
    [_contentViewController beginAppearanceTransition:YES animated:animated];
    
    __weak typeof(self) weakSelf = self;
    void (^block)(void) = ^void(void) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.containerView.backgroundColor = self.backgroundColor;
        strongSelf.contentViewController.view.frame = CGRectMake(strongSelf.containerRect.origin.x, strongSelf.containerRect.origin.y, strongSelf.contentViewController.view.frame.size.width, strongSelf.contentViewController.view.frame.size.height);
        strongSelf.contentBackgroundView.frame = CGRectMake(strongSelf.containerRect.origin.x, strongSelf.containerRect.origin.y, strongSelf.contentBackgroundView.frame.size.width, strongSelf.contentBackgroundView.frame.size.height);
        strongSelf.contentViewController.view.alpha = 1.0f;
        strongSelf.contentBackgroundView.alpha = 1.0f;
        strongSelf.contentBackgroundView.layer.shadowOpacity = strongSelf.backgroundColorAlpha;
        [strongSelf.contentViewController endAppearanceTransition];
    };
    if (animated) {
        [UIView animateWithDuration:_animationDuration delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:block completion:^(BOOL finished) {
            if (completion) {
                completion();
            }
        }];
    }
    else {
        block();
        if (completion) {
            completion();
        }
    }
}

- (void)addInViewController:(UIViewController *)viewController {
    UIViewAutoresizing resizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    resizingMask = [self contentViewAutoresizingMask];
    CGFloat alf = 0.0f;
    if ([self.backgroundColor getRed:nil green:nil blue:nil alpha:&alf]) {
        _backgroundColorAlpha = alf;
    }
    _presentingViewController = viewController;
    self.containerView.frame = viewController.view.bounds;
    self.containerView.backgroundColor = [UIColor clearColor];
    [viewController addChildViewController:_contentViewController];
    CGRect pcr = [self preOrPostAnimationContentRect];
    [_contentViewController.view setFrame:pcr];
    _contentViewController.view.autoresizingMask = resizingMask;
    [viewController.view addSubview:self.containerView];
    if (self.showShadow) {
        if (_contentBackgroundView==nil) {
            _contentBackgroundView = [[UIView alloc] init];
            _contentBackgroundView.backgroundColor = [UIColor whiteColor];
            _contentBackgroundView.clipsToBounds = NO;
        }
        
        _contentBackgroundView.frame = pcr;
        _contentBackgroundView.autoresizingMask = resizingMask;
        _contentBackgroundView.layer.shadowColor = [UIColor colorWithWhite:0.0f alpha:1.0f].CGColor;
        _contentBackgroundView.layer.shadowRadius = 15.0f;
        _contentBackgroundView.layer.shadowOpacity = 0.0f;
        _contentBackgroundView.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
        _contentBackgroundView.layer.shadowPath = [UIBezierPath bezierPathWithRect:_contentBackgroundView.bounds].CGPath;
        [self.containerView addSubview:_contentBackgroundView];
    }
    [self.containerView addSubview:_contentViewController.view];
    [_contentViewController didMoveToParentViewController:viewController];
    _contentViewController.view.alpha = 1.0f;
    _visible = YES;
    
    if (self.adjustsStatusBar) {
        // Update the status bar
        [self updateStatusBarInViewController:viewController];
    }
}

- (void)dismissAnimated:(BOOL)animated {
    if (self.onCompletion) {
        [self dismissAnimated:animated completion:self.onCompletion];
    }
    else {
        [self dismissAnimated:animated completion:nil];
    }
}

- (void)dismissAnimated:(BOOL)animated completion:(void (^ __nullable)(void))completion {
    CGRect targetRect = [self preOrPostAnimationContentRect];
    CGFloat targetAlpha = 1.0f;
    
    __weak typeof(self) weakSelf = self;
    void (^anim_completion)(BOOL finished) = ^void(BOOL finished) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf.contentViewController willMoveToParentViewController:nil];
        [strongSelf.containerView removeFromSuperview];
        [strongSelf.contentViewController removeFromParentViewController];
        UIViewController *vc = strongSelf.presentingViewController;
        strongSelf.presentingViewController = nil;
        strongSelf.visible = NO;
        if (strongSelf.adjustsStatusBar) {
            // Update the status bar
            [strongSelf updateStatusBarInViewController:vc];
        }
        if (completion) {
            completion();
        }
    };
    
    if (animated) {
        
        [UIView animateWithDuration:_animationDuration delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            __strong typeof(weakSelf) strongSelf = weakSelf;
            strongSelf.containerView.backgroundColor = [UIColor clearColor];
            strongSelf.contentViewController.view.frame = targetRect;
            strongSelf.contentBackgroundView.frame = targetRect;
            strongSelf.contentViewController.view.alpha = targetAlpha;
            strongSelf.contentBackgroundView.alpha = targetAlpha;
            strongSelf.contentBackgroundView.layer.shadowOpacity = 0.0f;
        } completion:anim_completion];
    }
    else {
        anim_completion(YES);
    }
}

- (void)updateStatusBarInViewController:(UIViewController *)vc {
    [self updateStatusBarInViewController:vc completion:nil];
}

- (void)updateStatusBarInViewController:(UIViewController *)vc completion:(void (^ __nullable)(BOOL finished))completion {
    [UIView animateWithDuration:0.25 animations:^{
        [vc setNeedsStatusBarAppearanceUpdate];
    } completion:completion];
}

- (void)handleTapGesture:(UITapGestureRecognizer *)gesture {
    CGPoint location = [gesture locationInView:self.containerView];
    if (!CGRectContainsPoint(self.contentViewController.view.frame, location)) {
        [self dismissAnimated:YES];
    }
}

- (void)setContentX:(CGFloat)x animated:(BOOL)animated {
    CGRect sideBarFrame = self.contentViewController.view.frame;
    sideBarFrame.origin.x = x;
    
    void (^block)(void) = ^void(void) {
        self.contentViewController.view.frame = sideBarFrame;
        self.contentBackgroundView.frame = sideBarFrame;
    };
    
    if (animated) {
        [UIView animateWithDuration:_animationDuration animations:block];
    }
    else {
        block();
    }
    
    [self adjustBackgroundAlpha];
}

- (void)setContentY:(CGFloat)y animated:(BOOL)animated {
    CGRect sideBarFrame = self.contentViewController.view.frame;
    sideBarFrame.origin.y = y;
    
    void (^block)(void) = ^void(void) {
        self.contentViewController.view.frame = sideBarFrame;
        self.contentBackgroundView.frame = sideBarFrame;
    };
    
    if (animated) {
        [UIView animateWithDuration:_animationDuration animations:block];
    }
    else {
        block();
    }
    
    [self adjustBackgroundAlpha];
}

- (void)adjustBackgroundAlpha {
    
    switch (_presentationStyle) {
        case SBMenuPresentationStyleSlideFromTop: {
            CGFloat alpha = MIN(CGRectGetMaxY(_contentBackgroundView.frame)*_backgroundColorAlpha/_containerRect.size.height, 1.0);
            self.containerView.backgroundColor = [self.backgroundColor colorWithAlphaComponent:alpha];
            _contentBackgroundView.layer.shadowOpacity = alpha;
        }
            break;
        case SBMenuPresentationStyleSlideFromLeft: {
            CGFloat alpha = MIN(CGRectGetMaxX(_contentBackgroundView.frame)*_backgroundColorAlpha/_containerRect.size.width, 1.0f);
            self.containerView.backgroundColor = [self.backgroundColor colorWithAlphaComponent:alpha];
            _contentBackgroundView.layer.shadowOpacity = alpha;
        }
            break;
        case SBMenuPresentationStyleSlideFromBottom: {
            CGFloat alpha = MIN((CGRectGetMaxY(_containerRect) - CGRectGetMinY(_contentBackgroundView.frame))*_backgroundColorAlpha/_containerRect.size.height, 1.0);
            self.containerView.backgroundColor = [self.backgroundColor colorWithAlphaComponent:alpha];
            _contentBackgroundView.layer.shadowOpacity = alpha;
        }
            break;
        case SBMenuPresentationStyleSlideFromRight: {
            CGFloat alpha = MIN((CGRectGetMaxX(_containerRect) - CGRectGetMinX(_contentBackgroundView.frame))*_backgroundColorAlpha/_containerRect.size.width, 1.0);
            self.containerView.backgroundColor = [self.backgroundColor colorWithAlphaComponent:alpha];
            _contentBackgroundView.layer.shadowOpacity = alpha;
        }
            break;
        default:
            break;
    }
    
    
}

- (void)handleMenuPanGesture:(nonnull UIPanGestureRecognizer *)recognizer inViewController:(nonnull UIViewController *)viewController {
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        
        if (recognizer.view!=self.containerView) {
            [self addInViewController:viewController];
        }
        
        self.panStartPoint = [recognizer locationInView:self.containerView];
        self.panStartContentRect = self.contentViewController.view.frame;
    }
    
    if (recognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint currentPoint = [recognizer locationInView:self.containerView];
        
        switch (_presentationStyle) {
            case SBMenuPresentationStyleSlideFromLeft:
                [self setContentX:MIN(self.panStartContentRect.origin.x + currentPoint.x - self.panStartPoint.x,_containerRect.origin.x) animated:NO];
                break;
            case SBMenuPresentationStyleSlideFromRight:
                [self setContentX:MAX(self.panStartContentRect.origin.x + currentPoint.x - self.panStartPoint.x ,_containerRect.origin.x) animated:NO];
                break;
            case SBMenuPresentationStyleSlideFromTop:
                [self setContentY:MIN(self.panStartContentRect.origin.y + currentPoint.y - self.panStartPoint.y,_containerRect.origin.y) animated:NO];
                break;
            case SBMenuPresentationStyleSlideFromBottom:
                [self setContentY:MAX(self.panStartContentRect.origin.y + currentPoint.y - self.panStartPoint.y ,_containerRect.origin.y) animated:NO];
                break;
            default:
                break;
        }
        
    }
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        CGPoint endPoint = [recognizer locationInView:self.containerView];
        
        switch (_presentationStyle) {
            case SBMenuPresentationStyleSlideFromLeft:
                if (endPoint.x - self.panStartPoint.x  > _containerRect.size.width/3) {
                    [self setContentX:_containerRect.origin.x animated:YES];
                }
                else {
                    [self dismissAnimated:YES];
                }
                break;
            case SBMenuPresentationStyleSlideFromRight:
                if (self.panStartPoint.x - endPoint.x > _containerRect.size.width/3) {
                    [self setContentX:_containerRect.origin.x animated:YES];
                }
                else {
                    [self dismissAnimated:YES];
                }
                break;
            case SBMenuPresentationStyleSlideFromTop:
                if (endPoint.y - self.panStartPoint.y  > _containerRect.size.width/3) {
                    [self setContentY:_containerRect.origin.y animated:YES];
                }
                else {
                    [self dismissAnimated:YES];
                }
                break;
            case SBMenuPresentationStyleSlideFromBottom:
                if (self.panStartPoint.y - endPoint.y > _containerRect.size.width/3) {
                    [self setContentY:_containerRect.origin.y animated:YES];
                }
                else {
                    [self dismissAnimated:YES];
                }
                break;
            default:
                break;
        }
    }
}

- (void)handlePanGesture:(UIPanGestureRecognizer *)recognizer {
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        
        self.panStartPoint = [recognizer locationInView:self.containerView];
        self.panStartContentRect = self.contentViewController.view.frame;
    }
    
    if (recognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint currentPoint = [recognizer locationInView:self.containerView];
        
        switch (_presentationStyle) {
            case SBMenuPresentationStyleSlideFromLeft:
                [self setContentX:MIN(self.panStartContentRect.origin.x + currentPoint.x - self.panStartPoint.x,_containerRect.origin.x) animated:NO];
                break;
            case SBMenuPresentationStyleSlideFromRight:
                [self setContentX:MAX(self.panStartContentRect.origin.x + currentPoint.x - self.panStartPoint.x ,_containerRect.origin.x) animated:NO];
                break;
            case SBMenuPresentationStyleSlideFromTop:
                [self setContentY:MIN(self.panStartContentRect.origin.y + currentPoint.y - self.panStartPoint.y,_containerRect.origin.y) animated:NO];
                break;
            case SBMenuPresentationStyleSlideFromBottom:
                [self setContentY:MAX(self.panStartContentRect.origin.y + currentPoint.y - self.panStartPoint.y ,_containerRect.origin.y) animated:NO];
                break;
            default:
                break;
        }
        
    }
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        CGPoint endPoint = [recognizer locationInView:self.containerView];
        
        switch (_presentationStyle) {
            case SBMenuPresentationStyleSlideFromLeft:
                if (endPoint.x - self.panStartPoint.x  > _containerRect.size.width/3) {
                    [self setContentX:_containerRect.origin.x animated:YES];
                }
                else {
                    [self dismissAnimated:YES];
                }
                break;
            case SBMenuPresentationStyleSlideFromRight:
                if (self.panStartPoint.x - endPoint.x > _containerRect.size.width/3) {
                    [self setContentX:_containerRect.origin.x animated:YES];
                }
                else {
                    [self dismissAnimated:YES];
                }
                break;
            case SBMenuPresentationStyleSlideFromTop:
                if (endPoint.y - self.panStartPoint.y  > _containerRect.size.height/3) {
                    [self setContentY:_containerRect.origin.y animated:YES];
                }
                else {
                    [self dismissAnimated:YES];
                }
                break;
            case SBMenuPresentationStyleSlideFromBottom:
                if (self.panStartPoint.y - endPoint.y > _containerRect.size.height/3) {
                    [self setContentY:_containerRect.origin.y animated:YES];
                }
                else {
                    [self dismissAnimated:YES];
                }
                break;
            default:
                break;
        }
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if (touch.view != gestureRecognizer.view) {
        return NO;
    }
    return YES;
}

@end
