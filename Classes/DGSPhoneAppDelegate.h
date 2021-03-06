//
//  DGSPhoneAppDelegate.h
//  DGSPhone
//
//  Created by Justin Weiss on 6/1/10.
//  Copyright Avvo 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DGSPhoneAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	UIViewController *viewController;
	UIImage *blackStone;
	UIImage *whiteStone;
	UIImage *boardImage;}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UIViewController *viewController;
@property (nonatomic, retain) UIImage *blackStone;
@property (nonatomic, retain) UIImage *whiteStone;
@property (nonatomic, retain) UIImage *boardImage;

- (void)replaceViewController:(UIViewController *)aViewController;

@end

