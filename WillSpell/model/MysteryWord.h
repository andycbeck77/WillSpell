//
//  MysteryWord.h
//  WillSpell
//
//  Created by Andy Beck on 11/4/13.
//  Copyright (c) 2013 Andy Beck. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MysteryWord : NSObject

@property (strong, nonatomic) NSArray *wordList;
@property (strong, nonatomic) NSArray *colorList;
@property (strong, nonatomic) NSMutableArray *guessedWord;
@property (strong, nonatomic) NSMutableArray *actualWord;

- (void) initCurrentWord:(NSString *) word;
- (void) initCurrentWordByIndex:(NSInteger) wordIndex;

- (BOOL) makeGuess:(NSString *)letter atIndex:(NSUInteger) index;
- (void) hint;

- (void) hint:(NSUInteger) numberOfLetters;

@end
