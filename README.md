WBSlidingViewController
=======================

A compound view controller for managing a front view controller (content view) and any number of back view controllers accessible by sliding the front view horizontally either direction.

To uses, simply copy WBSlidingViewController.m and WBSlidingViewController.h to your project's directory. Optionally, copy the images in "images" directory for use in UIBarButtonItem.

Example for setting up and use is in the .h comment header, but here it goes:

To use:

1. Instantiate a WBSlidingViewController

  WBSlidingViewController *svc = [[WBSlidingViewController alloc] init];


2. Add your front and back view controllers. If you want to receive delegate messages, then one of your
view controllers should adopt the WBSlidingViewControllerDelegate protocol as well.

	UIViewController *fvc = <...>;
	UIViewController<WBSlidingViewControllerDelegate> *bvc = <...>;

	svc.frontViewController = fvc;
	svc.backViewController = bvc;
	svc.delegage = bvc;

3. Set the back view's frame width to control the amount that the front view slides to reveal in the desire direction.
When the front view slides open, the sliding edge will line up with the opposite edge of the back view. Depending on the
direction chosen, the back view will be properly edge aligned to make the desired sliding effect work correctly. Optionally,
prior to sliding open the front view, the delegate will receive the message:

-slidingViewController:willSlideOpenInDirection:

at which time the delegate my swap in a different view controller to be displayed (the frame, again, must be adjusted for the
desired width, or the front will probably not open in the way you expect. Also note, for obvious reason, that if your back view controller
is also the delegate, make sure not to allow it to get deinstantiated if it is removed as the back view controller...but you already knew this, right?

4. Now, when you desire to "slide open" the front view controller, it is a simple matter of doing either
[svc slideOpenInDirection:WBSlidingViewDirectionLeft animated:YES completion:^(BOOL finished) {
	... do something after it opens to the left ...
}];

or

[svc slideOpenInDirection:WBSlidingViewDirectionRight animated:YES completion:^(BOOL finished) {
	... do something after it opens to the right ...
}];

5. To close the view, simply call:

[svc slideCloseAnimated:YES completion:^(BOOL finished) {
	... do something after it has closed ...
}];

6. To check the current open state, query with -isOpen or isOpenDirection:.

7. To check the current open direction -openDirection (wich returns WBSlidingViewDirectionUnknown if closed). 
