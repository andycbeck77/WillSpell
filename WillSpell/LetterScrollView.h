//
//  LetterScrollView.h
//  WillSpell
//
//  Created by Andy Beck on 9/26/13.
//  Copyright (c) 2013 Andy Beck. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MysteryWord.h"
#import "SpellViewController.h"

@interface LetterScrollView : UIView

@property (nonatomic) NSUInteger wordHeight;
@property (nonatomic) NSUInteger wordWidth;
@property (nonatomic) NSUInteger letterHeight;
@property (nonatomic) NSUInteger letterWidth;
@property (nonatomic) NSUInteger lettersPerRow;
@property (nonatomic) NSUInteger wordStart;
@property (nonatomic) NSUInteger letterStart;

@property (strong, nonatomic) NSMutableArray *theWord;

@property (strong, nonatomic) MysteryWord *mysteryWord;

@property (weak) id <WinnerDelegate> winnerDelegate;

- (void) setupLetters:(NSArray *) letterList;
- (void) refreshWord:(NSMutableArray *) currentWord withMysteryWord:(MysteryWord *) mysteryWord;
- (void) resetWordLetters:(NSMutableArray *) currentWord;
- (void) logRefresh:(NSMutableArray *)word;
- (void) logRefresh;

@end
