//
//  DGSTests.m
//  DGSPhone
//
//  Created by Justin Weiss on 6/3/10.
//  Copyright 2010 Avvo. All rights reserved.
//

#import "DGSTests.h"

@implementation DGSTests

- (void)testParseGames {
	NSString *testData = [NSString stringWithContentsOfFile:@"TestData/status.html"];
	DGS *dgs = [[DGS alloc] init];
	NSArray *games = [dgs gamesFromTable:testData];
	[dgs release];
	NSUInteger expectedCount = 3;
	STAssertEquals([games count], expectedCount, nil);
}

- (void)testBoardCoords {
	DGS *dgs = [[DGS alloc] init];
	STAssertEqualObjects(@"ss", [dgs sgfCoordsWithRow:1 column:19 boardSize:19], nil, nil );
	STAssertEqualObjects(@"aa", [dgs sgfCoordsWithRow:19 column:1 boardSize:19], nil, nil );
	STAssertEqualObjects(@"ab", [dgs sgfCoordsWithRow:18 column:1 boardSize:19], nil, nil );
}

@end
