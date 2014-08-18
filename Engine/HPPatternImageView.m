//
//  HPPatternImageView.m
//  V-POS
//
//  Created by nick liu on 12-11-11.
//  Copyright (c) 2012年 handpay. All rights reserved.
//

#import "HPPatternImageView.h"

@implementation HPPatternImageView

@synthesize image;

- (void)dealloc
{
    self.image = nil;
    
    //[super dealloc];
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame image:(UIImage *)img
{
    self = [self initWithFrame:frame];
    if (self) {
        self.image = img;
    }
    return self;
}

- (void)refreshImag:(UIImage *)img{
    self.image = img;
    [self setNeedsDisplay];
}

/*
// Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 */
- (void)drawRect:(CGRect)rect
{
    //CGContextRef context = UIGraphicsGetCurrentContext();
    [self.image drawAsPatternInRect:rect];
}


/*- (void) setImage:(UIImage *)image_
{
    if (image != image_) {
        [image release];
        image = [image_ retain];
        //[self setNeedsDisplay];
        //[self drawRect:self.frame];
    }
}*/

@end
