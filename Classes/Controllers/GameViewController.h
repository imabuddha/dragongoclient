//
//  GameViewController.h
//  DGSPhone
//
//  Created by Justin Weiss on 6/5/10.
//  Copyright 2010 Avvo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Game.h"
#import "GoBoardView.h"
#import "DGS.h"
#import "SpinnerView.h"

enum BoardState {
	kBoardStateZoomedOut,
	kBoardStateZoomedIn,
};

@interface GameViewController : UIViewController <LoginProtocol> {
	Game *game;
	FuegoBoard *board;
	DGS *dgs;
	IBOutlet GoBoardView *boardView;
	IBOutlet UIScrollView *scrollView;
	IBOutlet UIBarButtonItem *undoButton;
	IBOutlet UIBarButtonItem *zoomOutButton;
	IBOutlet UIBarButtonItem *confirmButton;
	IBOutlet UIBarButtonItem *passButton;
	IBOutlet UIBarButtonItem *resignButton;
	BoardState boardState;
	float maximumZoomScale;
	float minimumZoomScale;
	float currentZoomScale;
	SpinnerView *spinnerView;
}

@property (nonatomic, retain) SpinnerView *spinnerView;

@property(nonatomic, retain) Game *game;
@property(nonatomic, retain) FuegoBoard *board;
@property(nonatomic, retain) IBOutlet GoBoardView *boardView;
@property(nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property(nonatomic) BoardState boardState;
@property(nonatomic, retain) IBOutlet UIBarButtonItem *undoButton;
@property(nonatomic, retain) IBOutlet UIBarButtonItem *zoomOutButton;
@property(nonatomic, retain) IBOutlet UIBarButtonItem *confirmButton;
@property(nonatomic, retain) IBOutlet UIBarButtonItem *passButton;
@property(nonatomic, retain) IBOutlet UIBarButtonItem *resignButton;
@property(nonatomic, retain) DGS *dgs;

- (IBAction)undoMove;
- (IBAction)zoomOut;
- (IBAction)confirmMove;
- (IBAction)pass;
- (IBAction)resign;

- (void)notLoggedIn;
- (void)loggedIn;
- (void)requestCancelled;

@end

