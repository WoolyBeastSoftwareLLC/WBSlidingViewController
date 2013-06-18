//
//  BackViewController.m
//  SideSwipeView
//
//  Created by Scott Chandler on 4/12/13.
//  Copyright (c) 2013 Wooly Beast Software. All rights reserved.
//

#import "BackViewController.h"
#import "WBSlidingViewController.h"

@interface BackViewController ()
@end

@implementation BackViewController
- (id)initWithBackgroundColor:(UIColor *)bgColor label:(NSString *)labelText
{
	if ( self = [super init], self != nil ) {
		self.backgroundColor = bgColor;
		self.labelText = labelText;
	}
	return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)slidingViewController:(WBSlidingViewController *)svc willSlideOpenInDirection:(WBSlidingViewDirection)direction
{
	return direction == WBSlidingViewDirectionRight;
}

- (void)slidingViewController:(WBSlidingViewController *)svc didSlideCloseFromDirection:(WBSlidingViewDirection)direction
{
	
}

@end
