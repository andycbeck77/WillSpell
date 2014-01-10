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

-(NSDictionary *) loadGameData {
    self.isDataLoaded = YES;
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    //NSString *def = [NSString stringWithFormat:@"%@", [prefs dictionaryRepresentation]];
    //NSLog(@"%@", def);
    
    self.level = [prefs objectForKey:LEVEL_KEY];
    
    self.wordIndex = [prefs objectForKey:LAST_INDEX_KEY];

    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:self.level, LEVEL_KEY, self.wordIndex, LAST_INDEX_KEY, nil];
    
    return dict;
}

-(void) saveGameData:(NSUInteger) level forLastIndex:(NSUInteger) lastIndex {
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSNumber *theLevel = [NSNumber numberWithInt:level];
    NSNumber *theLastIndex = [NSNumber numberWithInt:lastIndex];
    [prefs setObject:theLevel forKey:LEVEL_KEY];
    [prefs setObject:theLastIndex forKey:LAST_INDEX_KEY];
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
