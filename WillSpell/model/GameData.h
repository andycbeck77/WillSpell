//
//  GameData.h
//  WillSpell
//
//  Created by Andy Beck on 11/22/13.
//  Copyright (c) 2013 Andy Beck. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameData : NSObject

@property (nonatomic) NSNumber *level;
@property (nonatomic) NSNumber *wordIndex;
@property (strong, nonatomic) NSMutableArray *randomizedIndices;
@property (nonatomic) BOOL isDataLoaded;
@property (nonatomic) BOOL isRandomArrayLoaded;

- (void) loadGameData;
- (void) saveGameData:(NSUInteger) level forLastIndex:(NSUInteger) lastIndex;
- (void) randomizeIndices:(NSInteger) startingNumber forSize:(NSUInteger) sizeList;
@end
