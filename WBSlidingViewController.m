//
//  WBSideSwipeViewController.m
//  SideSwipeView
//
//  Created by Scott Chandler on 4/12/13.
//  Copyright (c) 2013 Wooly Beast Software. All rights reserved.
//

#import "WBSlidingViewController.h"


NSString * const WBSlidingViewControllerWillSlideOpenNotification =		@"WBSlidingViewControllerWillSlideOpenNotification";
NSString * const WBSlidingViewControllerDidSlideOpenNotification =		@"WBSlidingViewControllerDidSlideOpenNotification";
NSString * const WBSlidingViewControllerWillSlideCloseNotification =	@"WBSlidingViewControllerWillSlideCloseNotification";
NSString * const WBSlidingViewControllerDidSlideCloseNotification =		@"WBSlidingViewControllerDidSlideCloseNotification";
NSString * const WBSlidingViewControllerDirectionKey =					@"WBSlidingViewControllerDirectionKey";

@interface WBSlidingViewController ()
- (BOOL)willSlideOpenInDirection:(WBSlidingViewDirection)direction;
- (void)didSlideOpenInDirection:(WBSlidingViewDirection)direction;
- (BOOL)willSlideCloseInDirection:(WBSlidingViewDirection)direction;
- (void)didSlideCloseInDirection:(WBSlidingViewDirection)direction;

- (void)adjustViews;
@end

@implementation WBSlidingViewController
@synthesize frontViewController=_frontViewController;
@synthesize backViewController=_backViewController;
@synthesize backViewWidth=_backViewWidth;

/*
 *
 *
 *
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

/*
 *
 *
 *
 */
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 *
 *
 *
 */
- (NSUInteger)supportedInterfaceOrientations
{
	return UIInterfaceOrientationMaskAll;
}

/*
 *
 *
 *
 */
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_6_0
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
	return YES;
}
#endif

/*
 *
 *
 *
 */
- (void)setFrontViewController:(UIViewController *)viewController
{
	[self setFrontViewController:viewController animated:NO];
}

/*
 *
 *
 *
 */
- (void)setFrontViewController:(UIViewController *)viewController animated:(BOOL)animated
{
	[_frontViewController willMoveToParentViewController:nil];
	[self addChildViewController:viewController];
		
	viewController.view.frame = self.view.bounds;
	
	if ( _frontViewController != nil ) {
		[self transitionFromViewController:_frontViewController
						  toViewController:viewController
								  duration:(animated) ? 0.5 : 0.0
								   options:UIViewAnimationOptionCurveEaseIn
								animations:^{
								}
								completion:^(BOOL finished) {
									[_frontViewController removeFromParentViewController];
									_frontViewController = viewController;
									[_frontViewController didMoveToParentViewController:self];
								}];
	}
	else {
		[_frontViewController.view removeFromSuperview];
		_frontViewController = viewController;
		[self.view addSubview:_frontViewController.view];
		[_frontViewController didMoveToParentViewController:self];
	}

}

/*
 *
 *
 *
 */
- (void)setBackViewController:(UIViewController *)viewController
{
	[self setBackViewController:viewController animated:NO];
}

/*
 *
 *
 *
 */
- (void)setBackViewController:(UIViewController *)viewController animated:(BOOL)animated
{
	[_backViewController willMoveToParentViewController:nil];
	[self addChildViewController:viewController];
	[_backViewController.view removeFromSuperview];
	
	_backViewController = viewController;
	
	_backViewController.view.frame = self.view.bounds;
	[self.view addSubview:_backViewController.view];
	[self.view sendSubviewToBack:_backViewController.view];
	[_backViewController didMoveToParentViewController:self];
}

/*
 *
 *
 *
 */
- (void)setBackViewWidth:(CGFloat)backViewWidth
{
	if ( _backViewWidth != backViewWidth ) {
		_backViewWidth = backViewWidth;
		[self adjustViews];
	}
}

/*
 *
 *
 *
 */
- (void)adjustViews
{
	if ( self.backViewController ) {
		CGRect rect = self.view.bounds;
		if ( _backViewWidth > 0.0 ) {
			rect.size.width = _backViewWidth;
			rect.origin.x = CGRectGetMinX(self.backViewController.view.frame);
		}
		else if ( _backViewWidth < 0.0 ) {
			rect.size.width += _backViewWidth;
			rect.origin.x = CGRectGetMinX(self.backViewController.view.frame);
			if ( rect.origin.x > 0.0 ) {
				rect.origin.x = CGRectGetMaxX(self.view.bounds) - CGRectGetWidth(rect);
			}
		}
		self.backViewController.view.frame = rect;
		
		if ( [self isOpen] ) {
			rect = self.frontViewController.view.frame;
			if ( [self openDirection] == WBSlidingViewDirectionLeft) {
				rect.origin.x = - CGRectGetWidth(self.backViewController.view.bounds);
			}
			else if ( [self openDirection] == WBSlidingViewDirectionRight ) {
				rect.origin.x = CGRectGetWidth(self.backViewController.view.bounds);
			}
			self.frontViewController.view.frame = rect;
		}
	}
}

/*
 *
 *
 *
 */
- (BOOL)willSlideOpenInDirection:(WBSlidingViewDirection)direction
{
	BOOL willOpen = YES;
	if ( self.delegate && [self.delegate respondsToSelector:@selector(slidingViewController:willSlideOpenInDirection:)]) {
		willOpen = [self.delegate slidingViewController:self willSlideOpenInDirection:direction];
	}
	if ( willOpen ) {
		[[NSNotificationCenter defaultCenter] postNotificationName:WBSlidingViewControllerWillSlideOpenNotification
														object:self
													  userInfo:@{WBSlidingViewControllerDirectionKey : @(direction)}];
	}
	return willOpen;
}

/*
 *
 *
 *
 */
- (void)didSlideOpenInDirection:(WBSlidingViewDirection)direction
{
	if ( self.delegate && [self.delegate respondsToSelector:@selector(slidingViewController:didSlideOpenInDirection:)]) {
		[self.delegate slidingViewController:self didSlideOpenInDirection:direction];
	}
	[[NSNotificationCenter defaultCenter] postNotificationName:WBSlidingViewControllerDidSlideOpenNotification
														object:self
													  userInfo:@{WBSlidingViewControllerDirectionKey : @(direction)}];
}

/*
 *
 *
 *
 */
- (BOOL)willSlideCloseInDirection:(WBSlidingViewDirection)direction
{
	BOOL willClose = YES;
	if ( self.delegate && [self.delegate respondsToSelector:@selector(slidingViewController:willSlideCloseInDirection:)]) {
		willClose = [self.delegate slidingViewController:self willSlideCloseInDirection:direction];
	}
	if ( willClose ) {
		[[NSNotificationCenter defaultCenter] postNotificationName:WBSlidingViewControllerWillSlideCloseNotification
															object:self
														  userInfo:@{WBSlidingViewControllerDirectionKey : @(direction)}];
	}
	return willClose;
	
}

/*
 *
 *
 *
 */
- (void)didSlideCloseInDirection:(WBSlidingViewDirection)direction
{
	if ( self.delegate && [self.delegate respondsToSelector:@selector(slidingViewController:didSlideCloseInDirection:)]) {
		[self.delegate slidingViewController:self didSlideCloseInDirection:direction];
	}
	[[NSNotificationCenter defaultCenter] postNotificationName:WBSlidingViewControllerDidSlideCloseNotification
														object:self
													  userInfo:@{WBSlidingViewControllerDirectionKey : @(direction)}];
}


static WBSlidingViewDirection DetermineSlideDirection( WBSlidingViewController *svc ) {
	UIView *frontView = svc.frontViewController.view;
	UIView *backView = svc.backViewController.view;
	
	WBSlidingViewDirection direction = WBSlidingViewDirectionUnknown;
	if ( CGRectGetMinX(frontView.frame) < CGRectGetMinX(backView.frame) ) {
		direction = WBSlidingViewDirectionLeft;
	}
	else if ( CGRectGetMaxX(frontView.frame) > CGRectGetMaxX(backView.frame)) {
		direction = WBSlidingViewDirectionRight;
	}
	
	return direction;
}
/*
 *
 *
 *
 */
const NSTimeInterval kSlideDuration = 0.3;
- (void)slideOpenAnimated:(BOOL)animated completion:(void (^)(WBSlidingViewDirection direction))completion
{
	NSAssert(self.frontViewController, @"Invalid front view controller (nil)");
	if ( self.frontViewController == nil ) {
		if ( completion ) {
			completion(WBSlidingViewDirectionUnknown);
		}
		return;
	}
	
	if ( [self isOpen] ) {
		if ( completion ) {
			completion(self.openDirection);
		}
		return;
	}
	
	WBSlidingViewDirection direction = DetermineSlideDirection(self);
	
	// allow the delegate the chance to swap in a different back view controller, or cancel the slide altogether
	BOOL allowOpen = [self willSlideOpenInDirection:direction];
	if ( self.backViewController == nil || !allowOpen ) {
		if ( completion ) {
			completion(WBSlidingViewDirectionUnknown);
		}
		return;
	}
	// make sure we start at zero
	CGRect frontFrame = self.frontViewController.view.frame;
	frontFrame.origin.x = 0.0;
	self.frontViewController.view.frame = frontFrame;
	
	// position our back view according to the desired direction
	CGRect backFrame = self.backViewController.view.frame;
	if ( direction == WBSlidingViewDirectionRight ) {
		backFrame.origin.x = 0.0;
		frontFrame.origin.x = CGRectGetMaxX(backFrame);
	}
	else if ( direction == WBSlidingViewDirectionLeft ) {
		backFrame.origin.x = CGRectGetMaxX(self.view.bounds) - CGRectGetWidth(backFrame);
		frontFrame.origin.x = -CGRectGetMaxX(backFrame) + CGRectGetMinX(backFrame);
	}
	self.backViewController.view.frame = backFrame;
	
	// animate it sucker
	[UIView animateWithDuration:(animated) ? kSlideDuration : 0.0
						  delay:0.0
						options:UIViewAnimationOptionCurveEaseInOut
					 animations:^{
						 self.frontViewController.view.frame = frontFrame;
					 }
					 completion:^(BOOL finished) {
						 if ( completion ) {
							 completion(direction);
						 }
						 [self didSlideOpenInDirection:direction];
					 }];
}

- (void)slideOpenInDirection:(WBSlidingViewDirection)direction animated:(BOOL)animated completion:(void (^)(WBSlidingViewDirection direction))completion
{
	NSAssert(self.frontViewController, @"Invalid front view controller (nil)");
	if ( self.frontViewController == nil ) {
		if ( completion ) {
			completion(WBSlidingViewDirectionUnknown);
		}
		return;
	}
	
	if ( [self isOpen] ) {
		if ( completion ) {
			completion(self.openDirection);
		}
		return;
	}
	
	// allow the delegate the chance to swap in a different back view controller, or cancel the slide altogether
	BOOL allowOpen = [self willSlideOpenInDirection:direction];
	if ( self.backViewController == nil || !allowOpen ) {
		if ( completion ) {
			completion(WBSlidingViewDirectionUnknown);
		}
		return;
	}
	// make sure we start at zero
	CGRect frontFrame = self.frontViewController.view.frame;
	frontFrame.origin.x = 0.0;
	self.frontViewController.view.frame = frontFrame;

	// position our back view according to the desired direction
	CGRect backFrame = self.backViewController.view.frame;
	if ( direction == WBSlidingViewDirectionRight ) {
		backFrame.origin.x = 0.0;
		frontFrame.origin.x = CGRectGetMaxX(backFrame);
	}
	else if ( direction == WBSlidingViewDirectionLeft ) {
		backFrame.origin.x = CGRectGetMaxX(self.view.bounds) - CGRectGetWidth(backFrame);
		frontFrame.origin.x = -CGRectGetMaxX(backFrame) + CGRectGetMinX(backFrame);
	}
	self.backViewController.view.frame = backFrame;
		
	// animate it sucker
	[UIView animateWithDuration:(animated) ? kSlideDuration : 0.0
						  delay:0.0
						options:UIViewAnimationOptionCurveEaseInOut
					 animations:^{
						 self.frontViewController.view.frame = frontFrame;
					 }
					 completion:^(BOOL finished) {
						 if ( completion ) {
							 completion(direction);
						 }
						 [self didSlideOpenInDirection:direction];
					 }];

}

/*
 *
 *
 *
 */
- (void)slideCloseAnimated:(BOOL)animated completion:(void (^)(WBSlidingViewDirection direction))completion
{
	if ( ![self isOpen] || !self.frontViewController || !self.backViewController ) {
		if ( completion ) {
			completion(WBSlidingViewDirectionUnknown);
		}
	}

	// determine the direction we must have opened
	WBSlidingViewDirection direction = [self openDirection];

	if ( [self willSlideCloseInDirection:direction]) {
		// current frame
		CGRect frame = self.frontViewController.view.frame;
		
		// set closed position
		frame.origin.x = 0.0;
		
		// animate
		[UIView animateWithDuration:(animated) ? kSlideDuration : 0.0
							  delay:0.0
							options:UIViewAnimationOptionCurveEaseInOut
						 animations:^{
							 self.frontViewController.view.frame = frame;
						 }
						 completion:^(BOOL finished) {
							 if ( completion ) {
								 completion(direction);
							 }
							 [self didSlideCloseInDirection:direction];
						 }];
	}
}

/*
 *
 *
 *
 */
- (BOOL)isOpen
{
	if ( self.frontViewController == nil ) return NO;
	
	WBSlidingViewDirection direction = [self openDirection];
	return direction == WBSlidingViewDirectionRight || direction == WBSlidingViewDirectionLeft;
}

/*
 *
 *
 *
 */
- (BOOL)isOpenInDirection:(WBSlidingViewDirection)direction
{
	return direction == [self openDirection];
}

/*
 *
 *
 *
 */
- (WBSlidingViewDirection)openDirection
{
	WBSlidingViewDirection direction = WBSlidingViewDirectionUnknown;
	CGRect frame = self.frontViewController.view.frame;
	if ( CGRectGetMinX(frame) < 0.0 ) {
		direction = WBSlidingViewDirectionLeft;
	}
	else if (CGRectGetMinX(frame) > 0.0 ) {
		direction = WBSlidingViewDirectionRight;
	}
	return direction;
}

/*
 *
 *
 *
 */
- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
	[super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
	
	[self adjustViews];
	
	if ( [self isOpen] ) {
		CGRect frontFrame = self.frontViewController.view.frame;
		CGRect backFrame = self.backViewController.view.frame;
		
		WBSlidingViewDirection direction = [self openDirection];
		if ( direction == WBSlidingViewDirectionLeft ) {
			frontFrame.origin.x = CGRectGetMinX(backFrame) - CGRectGetWidth(frontFrame);
		}
		else if ( direction == WBSlidingViewDirectionRight ) {
			frontFrame.origin.x = CGRectGetMaxX(backFrame);
		}
		
		[UIView animateWithDuration:duration
						 animations:^{
							 self.frontViewController.view.frame = frontFrame;
						 }];
		
	}
	
}

/*
 *
 *
 *
 */
- (IBAction)toggleSlidingView:(id)sender
{
	if ( [self isOpen] ) {
		[self slideCloseAnimated:YES
					  completion:nil];
	}
	else {
		[self slideOpenAnimated:YES
						completion:nil];
	}
}

@end

#pragma mark - 
@implementation UIViewController(WBSideSwipeViewController)
/*
 *
 *
 *
 */
- (WBSlidingViewController *)slidingViewController
{
	UIViewController *viewController = self.parentViewController;
	if ( [viewController isKindOfClass:[UINavigationController class]] ) {
		// go up one more level
		viewController = viewController.parentViewController;
	}
	
	if ( ![viewController isKindOfClass:[WBSlidingViewController class]] ) {
		viewController = nil;
	}

	return (WBSlidingViewController *)viewController;
}
@end
