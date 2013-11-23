//
//  GameData.m
//  WillSpell
//
//  Created by Andy Beck on 11/22/13.
//  Copyright (c) 2013 Andy Beck. All rights reserved.
//

#import "GameData.h"

#define GAME_DATA_KEY @"gameData"
#define LEVEL_KEY @"level"
#define LAST_INDEX_KEY @"lastIndex"


@implementation GameData

@synthesize level = _level;

- (NSNumber *) level {
    return _level;
}

- (void) setLevel:(NSNumber *)level {
    if (!level) {
        _level = 0;
    } else {
        _level = level;
    }
}

@synthesize wordIndex = _wordIndex;

- (NSNumber *) wordIndex {
    return _wordIndex;
}

- (void) setWordIndex:(NSNumber *)wordIndex {
    if (!wordIndex) {
        _wordIndex = 0;
    } else {
        _wordIndex = wordIndex;
    }
}

-(NSDictionary *) loadGameData {
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    if (![prefs objectForKey:LEVEL_KEY]) {
        self.level = [prefs objectForKey:LEVEL_KEY];
    }
    if (![prefs objectForKey:LAST_INDEX_KEY]) {
        self.wordIndex = [prefs objectForKey:LAST_INDEX_KEY];
    }
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

@end
