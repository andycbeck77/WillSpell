//
//  WordScrollView.m
//  WillSpell
//
//  Created by Andy Beck on 9/26/13.
//  Copyright (c) 2013 Andy Beck. All rights reserved.
//

#import "WordScrollView.h"
@interface WordScrollView()
@property (strong, nonatomic) NSArray *wordList;
@property (nonatomic) NSUInteger wordIndex;
@end

@implementation WordScrollView

#define WORD_WIDTH 35
#define WORD_HEIGHT 35
#define Y_START 5

- (NSArray *)wordList {
    return @[@"Apple",@"Banana",@"Pear"];
}

- (id)initWithFrame:(CGRect)frame
{

    self = [super initWithFrame:frame];

    return self;
}

- (void) setup {
    self.wordIndex=0;
    if (self) {
        NSString *currentWord = self.wordList[self.wordIndex];
        for (NSUInteger currentLetterIndex = 0; currentLetterIndex < [currentWord length]; currentLetterIndex++) {
            
            NSRange range = NSMakeRange (currentLetterIndex, 1);
            NSString *currentLetter = [currentWord substringWithRange:range];
            
            NSUInteger x = 5 + (WORD_WIDTH * currentLetterIndex);
            [self addSubview:[self createButton:currentLetter atX:x]];
        }
    }
}

- (UIButton *) createButton:(NSString *)title atX:(NSUInteger)x{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button addTarget:self
               action:@selector(wordLetterSelected:)
     forControlEvents:UIControlEventTouchDown];
    [button setTitle:title forState:UIControlStateNormal];
    button.frame = CGRectMake(x,Y_START,WORD_WIDTH, WORD_HEIGHT);
    return button;
}

- (UILabel *) createLabel:(NSString *)title atX:(NSUInteger)x {
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
    NSLog(clicked.titleLabel.text);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
