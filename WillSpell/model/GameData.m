//
//  GameData.m
//  WillSpell
//
//  Created by Andy Beck on 11/22/13.
//  Copyright (c) 2013 Andy Beck. All rights reserved.
//

#import "GameData.h"

#include <stdlib.h> 

#define GAME_DATA_KEY @"gameData"
#define LEVEL_KEY @"level"
#define LAST_INDEX_KEY @"lastIndex"
#define NUMBER_CORRECT_KEY @"numberCorrect"
#define NUMBER_WRONG_KEY @"numberWrong"
#define NUMBER_SKIPPED_KEY @"numberSkipped"

@interface GameData()

@end

@implementation GameData

@synthesize level = _level;

- (NSNumber *) level {
    if (!self.isDataLoaded) {
        [self loadGameData];
    }
    return _level;
}

- (void) setLevel:(NSNumber *)level {
    _level = level;
}

@synthesize wordIndex = _wordIndex;

- (NSNumber *) wordIndex {
    if (!self.isDataLoaded) {
        [self loadGameData];
    }
    return _wordIndex;
}

- (void) setWordIndex:(NSNumber *)wordIndex {
    _wordIndex = wordIndex;
}

@synthesize randomizedIndices = _randomizedIndices;

- (NSMutableArray *) randomizedIndices {
    if (!_randomizedIndices) {
        _randomizedIndices = [[NSMutableArray alloc] init];
    }
    
    return _randomizedIndices;
}

- (void) setRandomizedIndices:(NSArray *)randomizedIndices {
    _randomizedIndices = randomizedIndices;
}

@synthesize numberCorrect = _numberCorrect;
- (NSNumber *) numberCorrect {
    if (!self.isDataLoaded) {
        [self loadGameData];
    }
    
    if (!_numberCorrect) {
        _numberCorrect = [[NSNumber alloc] initWithInt:0];
    }
    
    return _numberCorrect;
}

- (void) setNumberCorrect:(NSNumber *)numberCorrect {
    _numberCorrect = numberCorrect;
}

@synthesize numberWrong = _numberWrong;
- (NSNumber *) numberWrong {
    if (!self.isDataLoaded) {
        [self loadGameData];
    }
    
    if (!_numberWrong) {
        _numberWrong = [[NSNumber alloc] initWithInt:0];
    }
    
    return _numberWrong;
}

- (void) setNumberWrong:(NSNumber *)numberWrong {
    _numberWrong = numberWrong;
}

@synthesize numberSkipped = _numberSkipped;
- (NSNumber *) numberSkipped {
    if (!self.isDataLoaded) {
        [self loadGameData];
    }
    
    if (!_numberSkipped) {
        _numberSkipped = [[NSNumber alloc] initWithInt:0];
    }

    return _numberSkipped;
}

- (void) setNumberSkipped:(NSNumber *)numberSkipped {
    _numberSkipped = numberSkipped;
}

-(NSDictionary *) loadGameData {
    self.isDataLoaded = YES;
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    //NSString *def = [NSString stringWithFormat:@"%@", [prefs dictionaryRepresentation]];
    //NSLog(@"%@", def);
    
    self.level = [prefs objectForKey:LEVEL_KEY];
    
    self.wordIndex = [prefs objectForKey:LAST_INDEX_KEY];
    
    self.numberCorrect = [prefs objectForKey:NUMBER_CORRECT_KEY];

    self.numberWrong = [prefs objectForKey:NUMBER_WRONG_KEY];
    
    self.numberSkipped = [prefs objectForKey:NUMBER_SKIPPED_KEY];

    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:self.level, LEVEL_KEY, self.wordIndex, LAST_INDEX_KEY, self.numberCorrect, NUMBER_CORRECT_KEY, self.numberWrong, NUMBER_WRONG_KEY, self.numberSkipped, NUMBER_SKIPPED_KEY, nil];
    
    return dict;
}

-(void) saveGameData:(NSUInteger) level forLastIndex:(NSUInteger) lastIndex forNumberCorrect:(NSInteger) numberCorrect forNumberWrong:(NSInteger) numberWrong forNumberSkipped:(NSInteger) numberSkipped {
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSNumber *theLevel = [NSNumber numberWithInt:level];
    NSNumber *theLastIndex = [NSNumber numberWithInt:lastIndex];
    
    self.level = theLevel;
    self.wordIndex = theLastIndex;
    
    [prefs setObject:theLevel forKey:LEVEL_KEY];
    [prefs setObject:theLastIndex forKey:LAST_INDEX_KEY];

    if (numberCorrect >= 0) {
        NSNumber *theNumberCorrect = [NSNumber numberWithInt:numberCorrect];
        [prefs setObject:theNumberCorrect forKey:NUMBER_CORRECT_KEY];
        self.numberCorrect = theNumberCorrect;
    }
    
    if (numberWrong >= 0) {
        NSNumber *theNumberWrong = [NSNumber numberWithInt:numberWrong];
        [prefs setObject:theNumberWrong forKey:NUMBER_WRONG_KEY];
        self.numberWrong = theNumberWrong;
    }
    
    if (numberSkipped >= 0) {
        NSNumber *theNumberSkipped = [NSNumber numberWithInt:numberSkipped];
        [prefs setObject:theNumberSkipped forKey:NUMBER_SKIPPED_KEY];
        self.numberSkipped = theNumberSkipped;
    }
    
    [prefs synchronize];
}

-(void) randomizeIndices:(NSInteger) startingNumber forSize:(NSUInteger) sizeList {
    int ar[sizeList];
    int i;
    int d;
    int tmp;
    int randomNumber;
    
    int indexOfStarter = 0;
    
    for (i=0; i < sizeList; i++) {
        ar[i]=i;
    }
    
    for (i=0; i < sizeList; i++) {
        randomNumber = arc4random() % (sizeList-i);
        d = i + randomNumber;
        tmp = ar[i];
        ar[i] = ar[d];
        ar[d] = tmp;
        
        if (ar[i]==startingNumber) {
            indexOfStarter = i;
        }
    }
    
    if (startingNumber >= 0) {        
        ar[indexOfStarter]=ar[0];
        ar[0]=startingNumber;
    }
    
    for (i=0; i < sizeList; i++) {
        [self.randomizedIndices addObject:[NSNumber numberWithInt:ar[i]]];
        NSLog(@"%d",ar[i]);
        
    }
    
    self.isRandomArrayLoaded = YES;

}

@end
