//
//  LetterScrollView.h
//  WillSpell
//
//  Created by Andy Beck on 9/26/13.
//  Copyright (c) 2013 Andy Beck. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LetterScrollView : UIScrollView

@property (nonatomic) NSUInteger selectedLetterIndex;
@property (nonatomic) NSString *selectedLetter;

- (void) setupWord;
- (void) setupLetters;


@end
