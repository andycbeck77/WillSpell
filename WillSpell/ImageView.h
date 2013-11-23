//
//  ImageView.h
//  WillSpell
//
//  Created by Andy Beck on 9/20/13.
//  Copyright (c) 2013 Andy Beck. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageView : UIImageView

@property (strong, nonatomic) NSString *imageName;

- (void)pinch:(UIPinchGestureRecognizer *)sender;
- (void)refreshImage:(NSString *) imageName;
- (void)changeImage:(NSString *) imageName;

@end
