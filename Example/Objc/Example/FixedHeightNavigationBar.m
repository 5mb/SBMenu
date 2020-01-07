//
//  FixedHeightNavigationBar.m
//  Example
//
//  Created by Soumen Bhuin on 23/03/16.
//  Copyright © 2016 smbhuin. All rights reserved.
//

#import "FixedHeightNavigationBar.h"

@implementation FixedHeightNavigationBar

- (void)setFrame:(CGRect)frame {
    frame.size.height = 64;
    [super setFrame:frame];
}

- (void)setCenter:(CGPoint)center {
    center.y = 42;
    [super setCenter:center];
}

@end
