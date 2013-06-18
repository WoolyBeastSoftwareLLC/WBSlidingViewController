//
//  SlidingTestViewController.m
//  SideSwipeView
//
//  Created by Scott Chandler on 4/14/13.
//  Copyright (c) 2013 Wooly Beast Software. All rights reserved.
//

#import "SlidingTestViewController.h"

@interface SlidingTestViewController ()
@property (strong) UILabel *label;
@end

@implementation SlidingTestViewController
@synthesize labelText=_labelText;
@synthesize backgroundColor=_backgroundColor;
@synthesize label=_label;

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
	self.view.backgroundColor = [UIColor whiteColor];
		
	self.label = [UILabel new];
	self.label.backgroundColor = [UIColor clearColor];
	self.label.text = @"Master";
	self.label.textColor = [UIColor whiteColor];
	self.label.font = [UIFont boldSystemFontOfSize:[UIFont labelFontSize]];
	self.label.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin;
	[self.label sizeToFit];
	self.label.center = (CGPoint){CGRectGetMidX(self.view.bounds),CGRectGetMidY(self.view.bounds)};
	[self.view addSubview:self.label];
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setLabelText:(NSString *)labelText
{
	self.label.text = labelText;
	[self.label sizeToFit];
}

- (NSString *)labelText
{
	return self.label.text;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
	self.view.backgroundColor = backgroundColor;
}

- (UIColor *)backgroundColor
{
	return self.view.backgroundColor;
}

- (NSUInteger)supportedInterfaceOrientations
{
	return UIInterfaceOrientationMaskAll;
}

@end
