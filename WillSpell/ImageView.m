//
//  ImageView.m
//  WillSpell
//
//  Created by Andy Beck on 9/20/13.
//  Copyright (c) 2013 Andy Beck. All rights reserved.
//

#import "ImageView.h"

#define RECTCORNER 12.0

@interface ImageView()
@property (nonatomic) CGFloat imageScaleFactor;
@end

@implementation ImageView

#pragma mark - Initialization

- (void) setup {
    
}

- (void) awakeFromNib {
    [self setup];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    [self setup];
    return self;
}

- (void)drawRect:(CGRect)rect
{
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:RECTCORNER];
    [roundedRect addClip];
    
    [[UIColor whiteColor] setFill];
    UIRectFill(self.bounds);
    
    [[UIColor blackColor] setStroke];
    [roundedRect stroke];
        
    UIImage *faceImage = [UIImage imageNamed:[NSString stringWithFormat:@"apple.png"]];
        
    CGRect imageRect = CGRectInset(self.bounds, self.bounds.size.width*(1.0-self.imageScaleFactor), self.bounds.size.height*(1.0-self.imageScaleFactor));
            
    [faceImage drawInRect:imageRect];
            
}

@synthesize imageScaleFactor = _imageScaleFactor;

- (CGFloat) imageScaleFactor {
    if (!_imageScaleFactor) {
        _imageScaleFactor = 0.90;
    }
    
    return _imageScaleFactor;
}

- (void) setImageScaleFactor:(CGFloat)faceCardScaleFactor {
    _imageScaleFactor = faceCardScaleFactor;
    [self setNeedsDisplay];
}

- (void)pinch:(UIPinchGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateChanged ||
        sender.state == UIGestureRecognizerStateEnded) {
        self.imageScaleFactor *= sender.scale;
        sender.scale = 1;
    }
}

@end
