//
//  WordScrollView.h
//  WillSpell
//
//  Created by Andy Beck on 9/26/13.
//  Copyright (c) 2013 Andy Beck. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WordScrollView : UIScrollView
@property (strong, nonatomic) NSString *word;
@property (nonatomic) NSUInteger selectedLetterIndex;

- (void) setup;

@end
