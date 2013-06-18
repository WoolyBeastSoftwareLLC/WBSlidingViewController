//
//  SlidingTestViewController.m
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
