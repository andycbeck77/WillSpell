//
//  LetterScrollView.m
//  WillSpell
//
//  Created by Andy Beck on 9/26/13.
//  Copyright (c) 2013 Andy Beck. All rights reserved.
//

#import "LetterScrollView.h"
#import "MysteryWord.h"

@interface LetterScrollView()

@property (strong, nonatomic) NSArray *letterList;
@property (nonatomic) NSUInteger letterIndex;

@property (strong, nonatomic) NSArray *wordList;
@property (nonatomic) NSUInteger wordIndex;

@end


@implementation LetterScrollView

#define WORD_WIDTH 35
#define WORD_HEIGHT 25
#define Y_START 5

#define WORD_Y_START 5
#define LETTER_Y_START  75


- (NSArray *)wordList {
    return @[@"APPLE",@"BANANA",@"PEAR"];
}

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

//////////////////////////////////// WORD ////////////////////////////////////

- (void) setupWord {
    self.wordIndex=0;
    if (self) {
        NSString *currentWord = self.wordList[self.wordIndex];
        for (NSUInteger currentLetterIndex = 0; currentLetterIndex < [currentWord length]; currentLetterIndex++) {
            
            NSRange range = NSMakeRange (currentLetterIndex, 1);
            NSString *currentLetter = [currentWord substringWithRange:range];
            
            NSUInteger x = 5 + (WORD_WIDTH * currentLetterIndex);
            [self addSubview:[self createButtonForWord:currentLetter atX:x]];
        }
    }
}

- (UIButton *) createButtonForWord:(NSString *)title atX:(NSUInteger)x{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button addTarget:self
               action:@selector(wordLetterSelected:)
     forControlEvents:UIControlEventTouchDown];
    [button setTitle:title forState:UIControlStateNormal];
    button.frame = CGRectMake(x,WORD_Y_START,WORD_WIDTH, WORD_HEIGHT);
    return button;
}

- (UILabel *) createLabelForWord:(NSString *)title atX:(NSUInteger)x {
    UILabel *lbl1 = [[UILabel alloc] init];
    [lbl1 setFrame:CGRectMake(x,5,WORD_WIDTH, WORD_HEIGHT)];
    lbl1.backgroundColor=[UIColor greenColor];
    lbl1.textColor=[UIColor blackColor];
    lbl1.userInteractionEnabled=YES;
    
    lbl1.text= title;
    return lbl1;
}

- (void)wordLetterSelected:(id)sender {
    UIButton *clicked = (UIButton *) sender;
    NSLog(clicked.titleLabel.text, nil);
}


////////////////////////////  LETTER  /////////////////////////////////

- (void) setupLetters {
    
    if (self) {
        
        NSUInteger x = 0;
        NSUInteger y = LETTER_Y_START;
        NSUInteger xcounter = 0;
        NSUInteger ycounter = 1;
        for (NSUInteger currentLetterIndex = 0; currentLetterIndex < [self.letterList count]; currentLetterIndex++) {
            
            NSString *currentLetter = self.letterList[currentLetterIndex];
            
            // 8 letters per row then new row
            if (xcounter < 9) {
                x = 5 + (WORD_WIDTH * xcounter);
                xcounter++;
            } else {
                xcounter = 0;
                x = 5 + (WORD_WIDTH * xcounter);
                y = LETTER_Y_START + (WORD_HEIGHT * ycounter) + 5;
                xcounter++;
                ycounter++;
            }
            
            [self addSubview:[self createButtonForLetters:currentLetter atX:x atY:y]];
        }
    }
}

- (UIButton *) createButtonForLetters:(NSString *)title atX:(NSUInteger)x atY:(NSUInteger)y {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button addTarget:self
               action:@selector(letterSelected:)
     forControlEvents:UIControlEventTouchDown];
    [button setTitle:title forState:UIControlStateNormal];
    button.frame = CGRectMake(x,y,WORD_WIDTH, WORD_HEIGHT);
    
    // add drag listener
	[button addTarget:self action:@selector(wasDragged:withEvent:)
    // forControlEvents:UIControlEventTouchDragInside];
      forControlEvents:UIControlEventTouchDragInside|UIControlEventTouchDragOutside];
     
    return button;
}

- (void)letterSelected:(id)sender {
    UIButton *clicked = (UIButton *) sender;
    NSString *letter = clicked.titleLabel.text;
    self.selectedLetter = letter;
    NSLog(@"%@", letter);
}

@synthesize selectedLetter = _selectedLetter;

- (void) setSelectedLetter:(NSString *)selectedLetter {
    _selectedLetter = selectedLetter;
}

- (NSString *) selectedLetter {
    return (_selectedLetter) ? _selectedLetter : @"?";
}

- (void)wasDragged:(UIButton *)button withEvent:(UIEvent *)event
{
	// get the touch
	UITouch *touch = [[event touchesForView:button] anyObject];
    
	// get delta
	CGPoint previousLocation = [touch previousLocationInView:button];
	CGPoint location = [touch locationInView:button];
	CGFloat delta_x = location.x - previousLocation.x;
	CGFloat delta_y = location.y - previousLocation.y;
    
	// move button
	button.center = CGPointMake(button.center.x + delta_x,
                                button.center.y + delta_y);
}

////////////////////////////////////////////////

@end
