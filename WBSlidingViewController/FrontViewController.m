//
//  FrontViewController.m
//
//	The MIT License (MIT)
//
//	Copyright (c) 2013 Wooly Beast Software
//
//	Permission is hereby granted, free of charge, to any person obtaining a copy
//	of this software and associated documentation files (the "Software"), to deal
//	in the Software without restriction, including without limitation the rights
//	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//	copies of the Software, and to permit persons to whom the Software is
//	furnished to do so, subject to the following conditions:
//
//	The above copyright notice and this permission notice shall be included in
//	all copies or substantial portions of the Software.
//
//	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//	THE SOFTWARE.
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
