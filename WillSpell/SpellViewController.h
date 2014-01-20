//
//  SpellViewController.h
//  WillSpell
//
//  Created by Andy Beck on 9/20/13.
//  Copyright (c) 2013 Andy Beck. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WordScrollView.h"

@protocol WinnerDelegate <NSObject>
- (void) winner;
- (void) wrong;
@end

@interface SpellViewController : UIViewController<WinnerDelegate>

@property (nonatomic) NSUInteger level;
@property (nonatomic) NSUInteger wordIndex;
@property (nonatomic) NSUInteger randomIndex;

@end
