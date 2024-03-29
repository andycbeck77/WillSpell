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

@property (nonatomic) NSUInteger letterIndex;

@property (strong, nonatomic) NSMutableArray *wordButtons;
@property (strong, nonatomic) NSMutableArray *letterButtons;

@property (strong, nonatomic) NSMutableArray *letterButtonLocations;

@end

@implementation LetterScrollView

#define SMALL_WORD_WIDTH 35 // orig 35
#define SMALL_WORD_HEIGHT 35 // orig 35

#define WORD_WIDTH 43 // orig 35
#define WORD_HEIGHT 43 // orig 35

#define MAX_WORD_FIT 7

#define Y_START 2

#define WORD_Y_START 2

#define LETTER_WIDTH 43 // orig 35
#define LETTER_HEIGHT 43 // orig 35

#define LETTER_Y_START  55 // orig 75
#define LETTERS_PER_ROW 7

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (NSMutableArray *) letterButtons {
    if (!_letterButtons) {
        _letterButtons = [[NSMutableArray alloc] init];
    }
    return _letterButtons;
}

- (NSMutableArray *) wordButtons {
    if (!_wordButtons) {
        _wordButtons = [[NSMutableArray alloc] init];
    }
    return _wordButtons;
}

- (NSMutableArray *) letterButtonLocations {
    if (!_letterButtonLocations) {
        _letterButtonLocations = [[NSMutableArray alloc] init];
    }
    return _letterButtonLocations;
}

- (NSUInteger) letterHeight {
    return LETTER_HEIGHT;
}

- (NSUInteger) letterWidth {
    return LETTER_WIDTH;
}

- (NSUInteger) wordHeight {
    if (self.theWord && self.theWord.count > MAX_WORD_FIT) {
        return SMALL_WORD_HEIGHT;
    }
    
    return WORD_HEIGHT;
}

- (NSUInteger) wordWidth {
    if (self.theWord && self.theWord.count > MAX_WORD_FIT) {
        return SMALL_WORD_WIDTH;
    }
    
    return WORD_WIDTH;
}

- (NSUInteger) lettersPerRow {
    return LETTERS_PER_ROW;
}

- (NSUInteger) wordStart {
    return WORD_Y_START;
}

- (NSUInteger) letterStart {
    return LETTER_Y_START;
}

- (void) refreshWord:(NSMutableArray *) currentWord withMysteryWord:(MysteryWord *) mysteryWord {
    [self clearWordButtons];
    self.wordButtons = nil;
    self.theWord = currentWord;
    
    for (NSUInteger currentLetterIndex = 0; currentLetterIndex < currentWord.count; currentLetterIndex++) {
        
        NSString *currentLetter = currentWord[currentLetterIndex];
        
        NSUInteger x = 5 + (self.wordWidth * currentLetterIndex);
        [self addSubview:[self createButtonForWord:currentLetter atX:x]];
    }
}

- (void) clearWordButtons {
    for (UIButton *b in self.wordButtons) {
        [b removeFromSuperview];
    }
}

- (void) setupLetters:(NSArray *) letterList {
    
    if (self) {
        
        NSUInteger x = 0;
        NSUInteger y = self.letterStart;
        NSUInteger xcounter = 0;
        NSUInteger ycounter = 1;
        for (NSUInteger currentLetterIndex = 0; currentLetterIndex < letterList.count; currentLetterIndex++) {
            
            NSString *currentLetter = letterList[currentLetterIndex];
            
            // letters per row then new row
            if (xcounter < self.lettersPerRow) {
                x = 5 + (self.letterWidth * xcounter);
                xcounter++;
            } else {
                xcounter = 0;
                x = 5 + (self.letterWidth * xcounter);
                y = self.letterStart + (self.letterHeight * ycounter) + 5;
                xcounter++;
                ycounter++;
            }
            
            [self addSubview:[self createButtonForLetters:currentLetter atX:x atY:y]];
        }
    }
}


- (void) resetWordLetters:(NSMutableArray *) currentWord {
    self.theWord = currentWord;
    for (NSUInteger index = 0; index < self.wordButtons.count; index++) {
        UIButton *obj = self.wordButtons[index];
        
        UIImage *aImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg", currentWord[index]]];
        if (aImage) {
            [obj setImage:aImage forState:UIControlStateNormal];
        }
        
        [obj setTitle:currentWord[index] forState:UIControlStateNormal];
    }
}

- (UIButton *) createButtonForWord:(NSString *)title atX:(NSUInteger)x{
    //UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button addTarget:self
               action:@selector(wordLetterSelected:)
     forControlEvents:UIControlEventTouchDown];
    
    UIImage *aImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg", title]];
    if (aImage) {
        [button setImage:aImage forState:UIControlStateNormal];
    }
    
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    button.frame = CGRectMake(x,self.wordStart,self.wordWidth, self.wordHeight);
    [self.wordButtons addObject:button];
    
    return button;
}

- (void)wordLetterSelected:(id)sender {
    UIButton *clicked = (UIButton *) sender;
    NSLog(clicked.titleLabel.text, nil);
}

- (UIButton *) createButtonForLetters:(NSString *)title atX:(NSUInteger)x atY:(NSUInteger)y {
    //UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self
               action:@selector(letterSelected:)
     forControlEvents:UIControlEventTouchDown];
    
    UIImage *aImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg", title]];
    if (aImage) {
        [button setImage:aImage forState:UIControlStateNormal];
    }
    
    [button setTitle:title forState:UIControlStateNormal];
    
    button.frame = CGRectMake(x,y,self.letterWidth, self.letterHeight);
    
    // add drag listener
	[button addTarget:self action:@selector(wasDragged:withEvent:)
    // forControlEvents:UIControlEventTouchDragInside];
      forControlEvents:UIControlEventTouchDragInside|UIControlEventTouchDragOutside];
    
    [button addTarget:self action:@selector(wasDropped:withEvent:)
     forControlEvents:UIControlEventTouchUpInside|UIControlEventTouchUpOutside];
    
    [self.letterButtons addObject:button];
    
    // store location for reset
    [self.letterButtonLocations addObject: [NSValue valueWithCGPoint:CGPointMake(button.center.x, button.center.y)]];
    
    return button;
}

- (void)letterSelected:(id)sender {
    UIButton *clicked = (UIButton *) sender;
    NSString *letter = clicked.titleLabel.text;
    NSLog(@"%@", letter);
}

- (void)wasDropped:(UIButton *)button withEvent:(UIEvent *)event 
{
    UITouch *touch = [[event touchesForView:button] anyObject];

    for (NSUInteger index = 0; index < self.wordButtons.count; index++) {
        UIButton *obj = self.wordButtons[index];
        
        CGPoint wordButtonCenter = obj.center;
        CGPoint letterButtonCenter = button.center;
        
        if (fabsf(wordButtonCenter.x-letterButtonCenter.x)<self.wordWidth-10
            && fabsf(wordButtonCenter.y-letterButtonCenter.y)<self.wordHeight-5) {
            
            BOOL correctGuess = [self.mysteryWord makeGuess:button.titleLabel.text atIndex:index];
            if (correctGuess) {
                [self resetWordLetters:self.mysteryWord.guessedWord];
                if ([self.mysteryWord completedWord]) {
                    [self.winnerDelegate winner];
                }
            } else {
                [self.winnerDelegate wrong];
            }
            
            //Move back button
            NSValue *objLocation = [self.letterButtonLocations objectAtIndex:[self.letterButtons indexOfObject:button]];
            CGPoint origin = [objLocation CGPointValue];
            button.center = CGPointMake(origin.x, origin.y);
        }
    }
    
    //Move back button
    NSValue *objLocation = [self.letterButtonLocations objectAtIndex:[self.letterButtons indexOfObject:button]];
    CGPoint origin = [objLocation CGPointValue];
    button.center = CGPointMake(origin.x, origin.y);

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
@synthesize winnerDelegate = _winnerDelegate;

- (void)setWinnerDelegate:(id<WinnerDelegate>)newDelegate
{
    _winnerDelegate = newDelegate;
}

- (id<WinnerDelegate>) winnerDelegate {
    return _winnerDelegate;
}

@end
