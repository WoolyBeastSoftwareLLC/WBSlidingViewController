//
//  SlidingTestViewController.h
//  SideSwipeView
//
//  Created by Scott Chandler on 4/14/13.
//  Copyright (c) 2013 Wooly Beast Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SlidingTestViewController : UIViewController
@property (nonatomic,strong) UIColor *backgroundColor;
@property (nonatomic,strong) NSString *labelText;

- (id)initWithBackgroundColor:(UIColor *)bgColor label:(NSString *)labelText;

@end
