//
//  WBSlidingViewController.h
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
//
//	Provides a simple sliding view over another view compound controller. In general, the front view
//	will be the content or details view, while the back view controller will be the navigation or master
//	view. However, to keep things generic, they are simply marked as "front" and "back".
//
//	This class is ARC compliant.
//
//	
//
//	To use:
//
//	1. Instantiate a WBSlidingViewController
//
//		WBSlidingViewController *svc = [[WBSlidingViewController alloc] init];
//
//
//	2. Add your front and back view controllers. If you want to receive delegate messages, then one of your
//	view controllers should adopt the WBSlidingViewControllerDelegate protocol as well.
//
//		UIViewController *fvc = <...>;
//		UIViewController<WBSlidingViewControllerDelegate> *bvc = <...>;
//
//		svc.frontViewController = fvc;
//		svc.backViewController = bvc;
//		svc.delegage = bvc;
//
//	3. Set the back view's frame width to control the amount that the front view slides to reveal in the desire direction.
//	When the front view slides open, the sliding edge will line up with the opposite edge of the back view. Depending on the
//	direction chosen, the back view will be properly edge aligned to make the desired sliding effect work correctly. Optionally,
//	prior to sliding open the front view, the delegate will receive the message:
//
//	-slidingViewController:willSlideOpenInDirection:
//
//	at which time the delegate my swap in a different view controller to be displayed (the frame, again, must be adjusted for the
//	desired width, or the front will probably not open in the way you expect. Also note, for obvious reason, that if your back view controller
//	is also the delegate, make sure not to allow it to get deinstantiated if it is removed as the back view controller...but you already knew this, right?
//
//	4. Now, when you desire to "slide open" the front view controller, it is a simple matter of doing either
//
//	[svc slideOpenInDirection:WBSlidingViewDirectionLeft animated:YES completion:^(BOOL finished) {
//		... do something after it opens to the left ...
//	}];
//
//	or
//
//	[svc slideOpenInDirection:WBSlidingViewDirectionRight animated:YES completion:^(BOOL finished) {
//		... do something after it opens to the right ...
//	}];
//
//	5. To close the view, simply call:
//
//	[svc slideCloseAnimated:YES completion:^(BOOL finished) {
//		... do something after it has closed ...
//	}];
//
//	6. To check the current open state, query with -isOpen or isOpenDirection:.
//
//	7. To check the current open direction -openDirection (wich returns WBSlidingViewDirectionUnknown if closed). 

#import <UIKit/UIKit.h>

enum {
	WBSlidingViewDirectionLeft,			// | <- ||
	WBSlidingViewDirectionRight,		// || -> |
	
	WBSlidingViewDirectionDefault = WBSlidingViewDirectionRight,
	WBSlidingViewDirectionUnknown =	NSUIntegerMax		// more than likely means it is closed
};
typedef NSUInteger WBSlidingViewDirection;


@protocol WBSlidingViewControllerDelegate;


@interface WBSlidingViewController : UIViewController
@property (weak) id<WBSlidingViewControllerDelegate> delegate;

@property (nonatomic,strong) UIViewController *frontViewController;
- (void)setFrontViewController:(UIViewController *)viewController animated:(BOOL)animated;

@property (nonatomic,strong) UIViewController *backViewController;
- (void)setBackViewController:(UIViewController *)viewController animated:(BOOL)animated;

// desired back view's width. 0.0 is full size (not recommended), > 0.0 is absolute width, < 0.0 is relative to full width
@property (nonatomic,readwrite) CGFloat backViewWidth;

- (void)slideOpenInDirection:(WBSlidingViewDirection)direction animated:(BOOL)animated completion:(void (^)(WBSlidingViewDirection direction))completion;
- (void)slideOpenAnimated:(BOOL)animated completion:(void (^)(WBSlidingViewDirection direction))completion;
- (void)slideCloseAnimated:(BOOL)animated completion:(void (^)(WBSlidingViewDirection direction))completion;

- (BOOL)isOpen;
- (BOOL)isOpenInDirection:(WBSlidingViewDirection)direction;
- (WBSlidingViewDirection)openDirection;		// returns WBSlidingViewDirectionUnknown when closed

- (IBAction)toggleSlidingView:(id)sender;

@end

@interface UIViewController(WBSlidingViewController)
@property (nonatomic,strong,readonly) WBSlidingViewController *slidingViewController;
@end


@protocol WBSlidingViewControllerDelegate <NSObject>
@optional
- (BOOL)slidingViewController:(WBSlidingViewController *)svc willSlideOpenInDirection:(WBSlidingViewDirection)direction;
- (void)slidingViewController:(WBSlidingViewController *)svc didSlideOpenInDirection:(WBSlidingViewDirection)direction;
- (BOOL)slidingViewController:(WBSlidingViewController *)svc willSlideCloseInDirection:(WBSlidingViewDirection)direction;
- (void)slidingViewController:(WBSlidingViewController *)svc didSlideCloseInDirection:(WBSlidingViewDirection)direction;
@end

extern NSString * const WBSlidingViewControllerWillSlideOpenNotification;
extern NSString * const WBSlidingViewControllerDidSlideOpenNotification;
extern NSString * const WBSlidingViewControllerWillSlideCloseNotification;
extern NSString * const WBSlidingViewControllerDidSlideCloseNotification;
extern NSString * const WBSlidingViewControllerDirectionKey;