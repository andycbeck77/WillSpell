//
//  SpellViewController.m
//  WillSpell
//
//  Created by Andy Beck on 9/20/13.
//  Copyright (c) 2013 Andy Beck. All rights reserved.
//

#import "SpellViewController.h"
#import "ImageView.h"
#import "LetterScrollView.h"

@interface SpellViewController () //<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet ImageView *imageView;
@property (weak, nonatomic) IBOutlet LetterScrollView *letterScrollView;

@end

@implementation SpellViewController

- (void)setImageView:(ImageView *)imageView {
    _imageView = imageView;
    [imageView addGestureRecognizer:[[UIPinchGestureRecognizer alloc] initWithTarget:imageView action:@selector(pinch:)]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // 320, 153
    self.letterScrollView.contentSize = CGSizeMake(1640.0, 640.0);
    
    [self.letterScrollView setupWord];
    [self.letterScrollView setupLetters];
    
    
}

@end
