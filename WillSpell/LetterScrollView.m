//
//  LetterScrollView.m
//  WillSpell
//
//  Created by Andy Beck on 9/26/13.
//  Copyright (c) 2013 Andy Beck. All rights reserved.
//

#import "LetterScrollView.h"
@interface LetterScrollView()
@property (strong, nonatomic) NSArray *letterList;
@property (nonatomic) NSUInteger wordIndex;
@end
@implementation LetterScrollView

#define WORD_WIDTH 35
#define WORD_HEIGHT 35
#define Y_START 5

- (NSArray *)letterList {
    return @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void) setup {
    
    if (self) {
        
        for (NSUInteger currentLetterIndex = 0; currentLetterIndex < [self.letterList count]; currentLetterIndex++) {
            
            NSString *currentLetter = self.letterList[currentLetterIndex];
            
            NSUInteger x = 5 + (WORD_WIDTH * currentLetterIndex);
            [self addSubview:[self createButton:currentLetter atX:x]];
        }
    }
}

- (UIButton *) createButton:(NSString *)title atX:(NSUInteger)x{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button addTarget:self
               action:@selector(letterSelected:)
     forControlEvents:UIControlEventTouchDown];
    [button setTitle:title forState:UIControlStateNormal];
    button.frame = CGRectMake(x,Y_START,WORD_WIDTH, WORD_HEIGHT);
    return button;
}

- (void)letterSelected:(id)sender {
    UIButton *clicked = (UIButton *) sender;
    NSLog(clicked.titleLabel.text);
}

@end
