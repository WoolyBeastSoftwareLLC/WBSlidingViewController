//
//  FrontViewController.m
//  SideSwipeView
//
//  Created by Scott Chandler on 4/13/13.
//  Copyright (c) 2013 Wooly Beast Software. All rights reserved.
//

#import "WBSlidingViewController.h"
#import "FrontViewController.h"
#import "BackViewController.h"

@interface FrontViewController ()
//- (void)buttonTapped:(id)sender;
- (void)swipedLeft:(UIGestureRecognizer *)gr;
- (void)swipedRight:(UIGestureRecognizer *)gr;
@end

@implementation FrontViewController
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
	
	UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:(CGRect){0.0,0.0,320.0,44.0}];
	toolbar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
	toolbar.items = [self toolbarItems];
	[self.view addSubview:toolbar];
	
	UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipedLeft:)];
	swipe.direction = UISwipeGestureRecognizerDirectionLeft;
	[toolbar addGestureRecognizer:swipe];
	
	swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipedRight:)];
	swipe.direction = UISwipeGestureRecognizerDirectionRight;
	[toolbar addGestureRecognizer:swipe];
	
#if 0
	UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[button setTitle:@"Push Me" forState:UIControlStateNormal];
	[button sizeToFit];
	[button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
#endif
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray *)toolbarItems
{
	return  @[[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Slider.png"] style:UIBarButtonItemStylePlain target:self action:@selector(left:)],
		   [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil]];
	
}

- (void)left:(id)sender
{
	WBSlidingViewController *controller = self.slidingViewController;
	if ( ![controller isOpen] ) {
		[controller slideOpenInDirection:WBSlidingViewDirectionRight
								animated:YES
							  completion:nil];
	}
	else {
		[controller slideCloseAnimated:YES
								completion:nil];
	}
}

- (void)swipedLeft:(UIGestureRecognizer *)gr
{
	WBSlidingViewController *controller = self.slidingViewController;
	if ( ![controller isOpen] ) {
		[controller slideOpenInDirection:WBSlidingViewDirectionLeft
								animated:YES
							  completion:nil];
	}
	else {
		[controller slideCloseAnimated:YES
							completion:nil];
	}
}

- (void)swipedRight:(UIGestureRecognizer *)gr
{
	[self left:gr];
}

@end
