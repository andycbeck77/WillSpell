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

- (void) setupLetters:(NSArray *) letterList;
- (void) refreshWord:(NSMutableArray *) currentWord withMysteryWord:(MysteryWord *) mysteryWord;
- (void) resetWordLetters:(NSMutableArray *) currentWord;
- (void) logRefresh:(NSMutableArray *)word;
- (void) logRefresh;

@property (strong, nonatomic) MysteryWord *mysteryWord;

@property (weak) id <WinnerDelegate> winnerDelegate;

@end
