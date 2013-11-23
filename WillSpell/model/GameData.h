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

- (void) loadGameData;
- (void) saveGameData:(NSUInteger) level forLastIndex:(NSUInteger) lastIndex;

@end
