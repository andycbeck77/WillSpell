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
@property (nonatomic) NSNumber *numberCorrect;
@property (nonatomic) NSNumber *numberWrong;
@property (nonatomic) NSNumber *numberSkipped;


- (void) loadGameData;
- (void) saveGameData:(NSUInteger) level forLastIndex:(NSUInteger) lastIndex forNumberCorrect:(NSInteger) numberCorrect forNumberWrong:(NSInteger) numberWrong forNumberSkipped:(NSInteger) numberSkipped;
- (void) randomizeIndices:(NSInteger) startingNumber forSize:(NSUInteger) sizeList;
@end
