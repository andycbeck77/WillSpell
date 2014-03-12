//
//  BigLetterScrollView.h
//  WillSpell
//
//  Created by Andy Beck on 3/5/14.
//  Copyright (c) 2014 Andy Beck. All rights reserved.
//

#import "LetterScrollView.h"

@interface BigLetterScrollView : LetterScrollView

@property (nonatomic) NSUInteger wordHeight;
@property (nonatomic) NSUInteger wordWidth;
@property (nonatomic) NSUInteger letterHeight;
@property (nonatomic) NSUInteger letterWidth;
@property (nonatomic) NSUInteger lettersPerRow;
@property (nonatomic) NSUInteger wordStart;
@property (nonatomic) NSUInteger letterStart;

@end
