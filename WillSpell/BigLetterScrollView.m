//
//  BigLetterScrollView.m
//  WillSpell
//
//  Created by Andy Beck on 3/5/14.
//  Copyright (c) 2014 Andy Beck. All rights reserved.
//

#import "BigLetterScrollView.h"

@implementation BigLetterScrollView

#define BIG_WORD_WIDTH 80 // orig 35
#define BIG_WORD_HEIGHT 80 // orig 35

#define BIG_LETTER_WIDTH 80 // orig 35
#define BIG_LETTER_HEIGHT 80 // orig 35

#define BIG_LETTERS_PER_ROW 9
#define BIG_WORD_Y_START 2
#define BIG_LETTER_Y_START 92


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (NSUInteger) letterHeight {
    return BIG_LETTER_HEIGHT;
}

- (NSUInteger) letterWidth {
    return BIG_LETTER_WIDTH;
}

- (NSUInteger) wordHeight {
    return BIG_WORD_HEIGHT;
}

- (NSUInteger) wordWidth {
    return BIG_WORD_WIDTH;
}

- (NSUInteger) lettersPerRow {
    return BIG_LETTERS_PER_ROW;
}

- (NSUInteger) wordStart {
    return BIG_WORD_Y_START;
}

- (NSUInteger) letterStart {
    return BIG_LETTER_Y_START;
}
@end
